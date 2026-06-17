import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../env/app_config.dart';
import '../storage/token_store.dart';

/// Attaches the bearer token (when present) and notifies on 401/403 so the app
/// can redirect to auth.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokens, {this.onUnauthorized});

  final TokenStore _tokens;
  final VoidCallback? onUnauthorized;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _tokens.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final code = err.response?.statusCode;
    if (code == 401 || code == 403) onUnauthorized?.call();
    handler.next(err);
  }
}

/// Simulates real-world conditions for the demo: 300–800 ms latency on every
/// call and an occasional transient failure on GETs (never on mutations) so the
/// app's loading / error / retry states are genuinely exercised.
class LatencyChaosInterceptor extends Interceptor {
  LatencyChaosInterceptor({Random? random}) : _rng = random ?? Random();

  final Random _rng;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final span = AppConfig.maxLatency.inMilliseconds -
        AppConfig.minLatency.inMilliseconds;
    final delay = AppConfig.minLatency.inMilliseconds + _rng.nextInt(span + 1);
    await Future<void>.delayed(Duration(milliseconds: delay));

    final isRead = options.method.toUpperCase() == 'GET';
    if (isRead &&
        AppConfig.flakyErrorRate > 0 &&
        _rng.nextDouble() < AppConfig.flakyErrorRate) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'Simulated transient network error',
        ),
      );
    }
    handler.next(options);
  }
}
