import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../env/app_config.dart';

/// Persists the auth token in [FlutterSecureStorage] while keeping a synchronous
/// in-memory copy so Dio's auth interceptor can read it without `await`.
class TokenStore {
  TokenStore(this._storage);

  final FlutterSecureStorage _storage;
  String? _cached;

  String? get token => _cached;

  Future<void> load() async {
    _cached = await _storage.read(key: AppConfig.tokenStorageKey);
  }

  Future<void> save(String token) async {
    _cached = token;
    await _storage.write(key: AppConfig.tokenStorageKey, value: token);
  }

  Future<void> clear() async {
    _cached = null;
    await _storage.delete(key: AppConfig.tokenStorageKey);
  }
}
