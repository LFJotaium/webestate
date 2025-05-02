import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FirebaseAuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  FirebaseAuth get _auth => FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;





  Future<UserCredential> registerWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _saveUserToFirestore(
      userId: userCredential.user!.uid,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
    );

    return userCredential;
  }

  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
    required WidgetRef ref,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<void> signOut(WidgetRef ref) async {
    try {
      await _auth.signOut();
    } catch (e) {
    }
  }


  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<void> _saveUserToFirestore({
    required String userId,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'firstName': firstName.trim(),
      'uid' : userId,
      'lastName': lastName.trim(),
      'phone': phone.trim(),
      'email': email.trim().toLowerCase(),
      'accountType': 'user',
      'verified': false,
      'subscriptionId': '',
      'listingsCount': 0,
      'savedEstatesCount': 0,
      'listingIds': [],
      'savedEstateIds' : [],
      'joinedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserProfile(WidgetRef ref, {
    String? name,
    String? phone,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return;

    try {
      final names = name?.split(' ') ?? [];
      final firstName = names.isNotEmpty ? names.first : '';
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      await _firestore.collection('users').doc(user.uid).update({
        if (name != null) 'firstName': firstName,
        if (name != null) 'lastName': lastName,
        if (phone != null) 'phone': phone,
      });

    } catch (e) {
      print('Error updating user profile: $e');
    }
  }
}