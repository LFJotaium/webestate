
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webestate/screens/update_screens/update_screen.dart';

import '../../data/models/estate_models/apartment_model.dart';
import '../../data/models/estate_models/house_model.dart';
import '../../data/models/estate_models/land_model.dart';
import '../../data/models/estate_models/villa_model.dart';
import '../profile/profile_screen.dart';
import '../screens/add_screens/apartments/apartment.dart';
import '../screens/add_screens/choose_screen.dart';
import '../screens/add_screens/houses/house.dart';
import '../screens/add_screens/lands/land.dart';
import '../screens/add_screens/villas/villa.dart';
import '../screens/auth/login.dart';
import '../screens/auth/registeration/register.dart';
import '../screens/estate_info_screens/apartment_estate_screen/apartment_estate.dart';
import '../screens/estate_info_screens/house_estate_screen/house_estate.dart';
import '../screens/estate_info_screens/land_estate_screen/land_estate.dart';
import '../screens/estate_info_screens/villa_estate_screen/villa_estate.dart';
import 'animation.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter appRouter(String initialRoute) {
  return GoRouter(
    navigatorKey: rootNavigatorKey, // Add this line
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionType: TransitionType.slideUp,
        ),
      ),

      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: const RegistrationScreen(),
          transitionType: TransitionType.slideUp,
        ),
      ),



      GoRoute(
        path: '/profile_screen',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: ProfileScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),

      GoRoute(
        path: '/update_screen',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: UpdateEstateScreen(estate: state.extra),
          transitionType: TransitionType.fadeThrough,
        ),
      ),
      GoRoute(
        path: '/estate_apartment',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: ApartmentDetailsPage(apartment: state.extra as Apartment),
          transitionType: TransitionType.slideUp,
        ),
      ),
      GoRoute(
        path: '/estate_house',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: HouseDetailsPage(house: state.extra as House),
          transitionType: TransitionType.slideUp,
        ),
      ),
      GoRoute(
        path: '/estate_land',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: LandDetailsPage(land: state.extra as Land),
          transitionType: TransitionType.slideUp,
        ),
      ),
      GoRoute(
        path: '/estate_villa',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: VillaDetailsPage(villa: state.extra as Villa),
          transitionType: TransitionType.slideUp,
        ),
      ),


      GoRoute(
        path: '/add_apartment',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: ApartmentOnboardingScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),
      GoRoute(
        path: '/add_house',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: HouseOnboardingScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),
      GoRoute(
        path: '/add_villa',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: VillaOnboardingScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),
      GoRoute(
        path: '/choose_screen',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: ChooseScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),
      GoRoute(
        path: '/add_land',
        pageBuilder: (context, state) => CustomTransition(
          key: state.pageKey,
          child: LandOnboardingScreen(),
          transitionType: TransitionType.fadeThrough,
        ),
      ),

    ],
  );
}
