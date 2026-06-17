import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../env/app_config.dart';
import '../storage/token_store.dart';
import 'interceptors.dart';

/// Builds the configured [Dio] instance: base URL, sane timeouts, auth +
/// latency/chaos + logging interceptors.
Dio buildDio(TokenStore tokens, {VoidCallback? onUnauthorized}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
      // json-server returns the X-Total-Count header for pagination.
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokens, onUnauthorized: onUnauthorized));
  dio.interceptors.add(LatencyChaosInterceptor());
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: false,
        logPrint: (o) => debugPrint('[dio] $o'),
      ),
    );
  }
  return dio;
}
