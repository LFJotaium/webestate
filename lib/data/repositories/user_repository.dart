import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';

import '../models/user_model.dart';

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

class UserNotifier extends StateNotifier<AsyncValue<UserModel>> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<DocumentSnapshot>? _userSub;

  UserNotifier(this._auth, this._firestore) : super(const AsyncValue.loading()) {
    // Don't initialize with guest immediately - wait for auth check
    _authSub = _auth.authStateChanges().listen(_onAuthStateChanged);
  }
  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _userSub?.cancel();
      state = AsyncValue.data(UserModel.guest());
      return;
    }

    try {
      _userSub?.cancel();
      final userDocRef = _firestore.collection('users').doc(firebaseUser.uid);

      _userSub = userDocRef.snapshots().listen((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          state = AsyncValue.data(UserModel.fromMap(firebaseUser.uid, snapshot.data()!));
        } else {
          // Fallback to guest if user doc doesn't exist
          state = AsyncValue.data(UserModel.guest());
        }
      }, onError: (e) {
        // Fallback to guest on Firestore errors
        state = AsyncValue.data(UserModel.guest());
      });
    } catch (e) {
      // Fallback to guest on any other errors
      state = AsyncValue.data(UserModel.guest());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      state = const AsyncValue.loading();

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.reload();
      await _onAuthStateChanged(_auth.currentUser);

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print(e);
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'البريد الإلكتروني غير مسجل.';
          break;
        case 'invalid-credential':
          errorMessage = 'كلمة المرور او البريد الالكتروني غير صحيحة.';
          break;
        case 'invalid-email':
          errorMessage = 'البريد الإلكتروني غير صالح.';
          break;
        case 'user-disabled':
          errorMessage = 'تم تعطيل هذا الحساب.';
          break;
        case 'too-many-requests':
          errorMessage = 'محاولات كثيرة. حاول مرة أخرى لاحقاً.';
          break;
        case 'network-request-failed':
          errorMessage = 'فشل الاتصال بالإنترنت. تحقق من الشبكة.';
          break;
        default:
          errorMessage = 'حدث خطأ أثناء تسجيل الدخول. حاول مرة أخرى.';
          break;
      }

      GFToast.showToast(
          errorMessage,
          context,
          toastPosition: GFToastPosition.CENTER,

          backgroundColor: Colors.red

      );

      state = AsyncValue.data(UserModel.guest());

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ غير متوقع أثناء تسجيل الدخول.'),
          backgroundColor: Colors.red,
        ),
      );

      state = AsyncValue.data(UserModel.guest());
    }
  }


  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Auth state listener will handle switching to guest
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _userSub?.cancel();
    super.dispose();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<UserModel>>((ref) {
  return UserNotifier(
    ref.read(authProvider),
    ref.read(firestoreProvider),
  );
});

// Helper providers
final currentUserProvider = Provider<UserModel>((ref) {
  return ref.watch(userProvider).value ?? UserModel.guest();
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(userProvider).value;
  return user != null && !user.isGuest;
});

final isGuestProvider = Provider<bool>((ref) {
  final user = ref.watch(userProvider).value;
  return user?.isGuest ?? true;
});