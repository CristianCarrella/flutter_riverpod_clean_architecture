import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_clean_architecture/core/providers/service_providers/storage_providers.dart';
import 'package:flutter_riverpod_clean_architecture/core/localizations/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _languageCodeKey = 'selected_language_code';

final savedLocaleProvider = Provider<Locale>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final savedLanguageCode = prefs.getString(_languageCodeKey);

  if (savedLanguageCode != null &&
      AppLocalizations.supportedLocales.any(
        (l) => l.languageCode == savedLanguageCode,
      )) {
    return Locale(savedLanguageCode);
  }

  final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
  if (AppLocalizations.isSupported(systemLocale)) {
    return systemLocale;
  }

  return const Locale('en');
});

final persistentLocaleProvider =
    StateNotifierProvider<PersistentLocaleNotifier, Locale>((ref) {
      final prefs = ref.watch(sharedPreferencesProvider);
      final initialLocale = ref.watch(savedLocaleProvider);

      return PersistentLocaleNotifier(prefs, initialLocale);
    });

class PersistentLocaleNotifier extends StateNotifier<Locale> {
  PersistentLocaleNotifier(this._prefs, Locale initialLocale)
    : super(initialLocale);

  final SharedPreferences _prefs;

  Future<void> setLocale(Locale locale) async {
    if (AppLocalizations.isSupported(locale)) {
      await _prefs.setString(_languageCodeKey, locale.languageCode);
      state = locale;
    }
  }

  Future<void> resetToSystemLocale() async {
    await _prefs.remove(_languageCodeKey);
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    if (AppLocalizations.isSupported(systemLocale)) {
      state = systemLocale;
    } else {
      state = const Locale('en');
    }
  }
}
