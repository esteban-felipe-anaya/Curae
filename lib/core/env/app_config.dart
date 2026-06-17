import 'package:flutter/foundation.dart';

/// App-wide configuration. The mock API base URL is overridable at build time:
///
///   flutter run --dart-define=CURAE_API_BASE_URL=http://10.0.2.2:3000
///
/// Defaults are chosen per-platform so the bundled `json-server` is reachable
/// out of the box (Android emulators tunnel localhost via 10.0.2.2).
class AppConfig {
  AppConfig._();

  static const String _override =
      String.fromEnvironment('CURAE_API_BASE_URL', defaultValue: '');

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
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
