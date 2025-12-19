import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/accessibility_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/localization_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/storage_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/app_router_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_riverpod_clean_architecture/core/localizations/app_localizations_delegate.dart';
import 'package:flutter_riverpod_clean_architecture/core/localizations/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Run the app with ProviderScope to enable Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override the shared preferences provider with the instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override the default locale provider to use our persistent locale
        defaultLocaleProvider.overrideWith(
          (ref) => ref.watch(persistentLocaleProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Provider to manage theme mode
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router from provider
    final router = ref.watch(routerProvider);

    // Watch the theme mode
    final themeMode = ref.watch(themeModeProvider);

    // Watch the persistent locale
    final locale = ref.watch(persistentLocaleProvider);

    return AccessibilityWrapper(
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
