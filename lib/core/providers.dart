import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/curae_api.dart';
import '../data/repositories/appointment_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/content_repository.dart';
import '../data/repositories/doctor_repository.dart';
import 'env/app_config.dart';
import 'network/dio_client.dart';
import 'storage/token_store.dart';

/// Overridden in `main()` with the loaded instance.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

/// Overridden in `main()` with a [TokenStore] whose token is preloaded.
final tokenStoreProvider = Provider<TokenStore>(
  (ref) => throw UnimplementedError('tokenStoreProvider must be overridden'),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final dioProvider = Provider(
  (ref) => buildDio(ref.watch(tokenStoreProvider)),
);

final curaeApiProvider = Provider(
  (ref) => CuraeApi(ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(ref.watch(curaeApiProvider), ref.watch(tokenStoreProvider)),
);

final doctorRepositoryProvider = Provider(
  (ref) => DoctorRepository(ref.watch(curaeApiProvider)),
);

final appointmentRepositoryProvider = Provider(
  (ref) => AppointmentRepository(ref.watch(curaeApiProvider)),
);

final contentRepositoryProvider = Provider(
  (ref) => ContentRepository(ref.watch(curaeApiProvider)),
);

// --- Theme mode -------------------------------------------------------------
class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final raw = ref.read(sharedPreferencesProvider).getString(AppConfig.themeModeKey);
    return ThemeMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(AppConfig.themeModeKey, mode.name);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

// --- Locale -----------------------------------------------------------------
/// Supported locales for the demo (English / Spanish for the LATAM market).
const supportedLocales = [Locale('en'), Locale('es')];

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() {
    final raw = ref.read(sharedPreferencesProvider).getString(AppConfig.localeKey);
    if (raw == null || raw.isEmpty) return null; // follow system
    return Locale(raw);
  }

  Future<void> set(Locale? locale) async {
    state = locale;
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(AppConfig.localeKey);
    } else {
      await prefs.setString(AppConfig.localeKey, locale.languageCode);
    }
  }
}

final localeProvider =
    NotifierProvider<LocaleController, Locale?>(LocaleController.new);
