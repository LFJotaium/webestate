import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';
import 'firebase_options_app2.dart' as option2;

class FirebaseInstances {
  static Completer<void>? _initCompleter;

  static late FirebaseFirestore primary;
  static late FirebaseFirestore secondary;
  static bool _initializing = false;

  Future<void> initializeFirebase() async {
    if (_initCompleter != null && _initCompleter!.isCompleted) {
      log('[FirebaseInstances] Firebase already initialized');
      return;
    }

    if (_initializing) {
      log('[FirebaseInstances] Firebase is already initializing');
      return _initCompleter!.future;
    }

    _initializing = true;
    _initCompleter ??= Completer();

    try {
      log('[FirebaseInstances] Initializing Firebase apps...');

      final defaultApp = await _initializeDefaultApp();
      log('[FirebaseInstances] Default Firebase app initialized');

      final secondaryApp = await _initializeSecondaryApp();
      log('[FirebaseInstances] Secondary Firebase app initialized');

      _setupFirestoreInstances(
          primaryApp: defaultApp, secondaryApp: secondaryApp);

      log('[FirebaseInstances] Firebase initialization completed successfully');
      _initCompleter!.complete();
    } catch (e, stack) {
      log('[FirebaseInstances] Firebase initialization failed',
          error: e, stackTrace: stack);
      _initCompleter!.completeError(e, stack);
      if (!kDebugMode) rethrow;
    } finally {
      _initializing = false;
    }

    return _initCompleter!.future;
  }

  Future<FirebaseApp> _initializeDefaultApp() async {
    try {
      return Firebase.app(); // Try to get the default app
    } catch (e) {
      return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  Future<FirebaseApp> _initializeSecondaryApp() async {
    const secondaryName = 'SecondaryApp';
    try {
      if (Firebase.apps.any((app) => app.name == secondaryName)) {
        log('[FirebaseInstances] Secondary Firebase app already exists');
        return Firebase.app(secondaryName);
      } else {
        log('[FirebaseInstances] Initializing secondary Firebase app...');
        return await Firebase.initializeApp(
          name: secondaryName,
          options: option2.DefaultFirebaseOptions.currentPlatform,
        );
      }
    } on FirebaseException catch (e) {
      log('[FirebaseInstances] Error initializing secondary app', error: e);
      rethrow;
    }
  }

  void _setupFirestoreInstances({
    required FirebaseApp primaryApp,
    required FirebaseApp secondaryApp,
  }) {
    log('[FirebaseInstances] Setting up Firestore instances...');

    primary = FirebaseFirestore.instanceFor(app: primaryApp);
    primary.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    secondary = FirebaseFirestore.instanceFor(app: secondaryApp);
    secondary.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }



  bool get isInitialized => _initCompleter?.isCompleted ?? false;
}
