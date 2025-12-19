import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/view_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authProvider.notifier).checkAuthStatus();

      final authState = ref.read(authProvider);
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return;

      if (authState.isAuthenticated) {
        context.go(AppConstants.homeRoute);
      } else {
        context.go(AppConstants.loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
