import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// App-wide configuration. The backend base URL is resolved, in order of
/// precedence:
///   1. `--dart-define=CURAE_API_BASE_URL=...` (compile-time override, e.g. CI)
///   2. `CURAE_API_BASE_URL` in the `.env` file (loaded at startup; see .env.example)
///   3. a per-platform default pointing at the Curae backend (NestJS, see `backend/`)
///
/// Android emulators reach the host via 10.0.2.2; a physical device should set
/// its LAN IP in `.env` (or via the --dart-define override).
class AppConfig {
  AppConfig._();

  static const String _override = String.fromEnvironment(
    'CURAE_API_BASE_URL',
    defaultValue: '',
  );

  static const String _envKey = 'CURAE_API_BASE_URL';

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;

    final fromEnv = dotenv.isInitialized ? dotenv.maybeGet(_envKey) : null;
    if (fromEnv != null && fromEnv.trim().isNotEmpty) return fromEnv.trim();

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://localhost:8000';
  }

  /// Simulated network behaviour for the demo (Dio interceptor).
  static const Duration minLatency = Duration(milliseconds: 300);
  static const Duration maxLatency = Duration(milliseconds: 800);

  /// Probability (0..1) that a non-mutating GET fails transiently, so the UI's
  /// error + retry states are exercised. Set 0 to disable. Mutations never fail.
  static const double flakyErrorRate = kDebugMode ? 0.06 : 0.0;

  static const String appName = 'Curae';
  static const String tokenStorageKey = 'curae_auth_token';
  static const String themeModeKey = 'curae_theme_mode';
  static const String localeKey = 'curae_locale';
  static const String remindersKey = 'curae_reminders';
}
