import '../../core/network/api_exception.dart';
import '../../core/storage/token_store.dart';
import '../api/curae_api.dart';
import '../models/user.dart';

class AuthRepository {
  AuthRepository(this._api, this._tokens);

  final CuraeApi _api;
  final TokenStore _tokens;

  bool get hasToken => (_tokens.token ?? '').isNotEmpty;

  Future<AppUser> login(String email, String password) async {
    try {
      final res = await _api.login({'email': email, 'password': password});
      await _tokens.save(res.token);
      return res.user;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final res = await _api.register({
        'name': name,
        'email': email,
        'password': password,
        'phone': ?phone,
      });
      await _tokens.save(res.token);
      return res.user;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  /// Restores the session on launch. Returns null if there is no valid token.
  Future<AppUser?> restore() async {
    if (!hasToken) return null;
    try {
      final res = await _api.me();
      return res.user;
    } catch (e) {
      final ex = ApiException.from(e);
      if (ex.isUnauthorized) await _tokens.clear();
      return null;
    }
  }

  Future<void> logout() => _tokens.clear();
}
