import 'dart:developer';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webestate/core/auth_service/fiirebase_auth_service.dart';

import '../core/firebase_instances.dart';
import '../core/firebase_service/firebase_service.dart';
import '../core/limited_cache_manager.dart';
import '../core/theme.dart';
import '../l10n/generated/app_localizations.dart';
import '../routing/routings.dart';
final GlobalKey<_MyAppState> myAppKey = GlobalKey<_MyAppState>();
late Locale _locale;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  if (Firebase.apps.isEmpty) {
    print("HERE");
    await FirebaseInstances().initializeFirebase();
  } else {
    log('[main] Firebase already initialized, skipping initialization');
  }



  FirebaseService().cloudfareInit();
  // Image caching
  PaintingBinding.instance.imageCache.maximumSize = 20;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 2 * 1024 * 1024;

  // Launch app
  const savedLanguage = 'ar';
  var initialRoute;
  if(FirebaseAuthService().getCurrentUser() !=null ){
    initialRoute = '/profile_screen';
  }
  else{
    initialRoute = '/login';
  }

  runApp(
    UncontrolledProviderScope(
      container: ProviderContainer(),
      child: MyApp(
          savedLanguage: savedLanguage,
          initialRoute: initialRoute
      ),
    ),
  );
}




class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.savedLanguage,
    required this.initialRoute,
  }) : super(key: key);

  final String savedLanguage;
  final String initialRoute;



  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _initializeApp();
  }


  Future<void> _initializeApp() async {
    _locale = Locale(widget.savedLanguage);
    _router = appRouter(widget.initialRoute);
    // Image cache settings
    PaintingBinding.instance.imageCache.maximumSize = 50;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 10 * 1024 * 1024;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ImageCacheManager().nukeImageCaches();
      await ImageCacheManager().applyCacheAgingPolicy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder:(context, child) {
      return Scrollbar(child: child!);  // Wrap all child content in a Scrollbar
    },
      key: ValueKey(_locale.languageCode),
      title: 'Bayti',
      theme: getTheme(_locale),
      routerConfig: _router,
      supportedLocales: const [
        Locale('he'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar'),
    );
  }
}
