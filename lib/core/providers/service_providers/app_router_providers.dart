import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/localization_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/router/locale_aware_router.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/screens/login_screen.dart';
import 'package:flutter_riverpod_clean_architecture/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/screens/serie_a_screen.dart';
import '../../../presentation/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(persistentLocaleProvider);

  return GoRouter(
    initialLocation: AppConstants.initialRoute,
    debugLogDiagnostics: true,
    observers: [ref.read(localizationRouterObserverProvider)],
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const SerieAScreen(),
      ),

      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: AppConstants.registerRoute,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: AppConstants.initialRoute,
        name: 'initial',
        builder: (context, state) => const SplashScreen(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: Center(child: Text('Page ${state.uri.path} not found')),
        ),
  );
});
