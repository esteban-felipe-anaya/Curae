import 'package:dio/dio.dart';

/// Centralised, typed error surface for the whole app. Repositories convert any
/// [DioException] into one of these so the UI can render a friendly message.
enum ApiErrorKind { network, timeout, unauthorized, notFound, server, unknown }

class ApiException implements Exception {
  const ApiException(this.kind, this.message, {this.statusCode});

  final ApiErrorKind kind;
  final String message;
  final int? statusCode;

  bool get isUnauthorized => kind == ApiErrorKind.unauthorized;

  factory ApiException.from(Object error) {
    if (error is ApiException) return error;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ApiException(
            ApiErrorKind.timeout,
            'The request timed out. Please try again.',
          );
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return const ApiException(
            ApiErrorKind.network,
            "Can't reach the server. Check that the Curae backend is running.",
          );
        case DioExceptionType.badCertificate:
          return const ApiException(ApiErrorKind.network, 'Bad certificate.');
        case DioExceptionType.cancel:
          return const ApiException(ApiErrorKind.unknown, 'Request cancelled.');
        case DioExceptionType.badResponse:
          final code = error.response?.statusCode;
          if (code == 401 || code == 403) {
            return ApiException(
              ApiErrorKind.unauthorized,
              'Please sign in to continue.',
              statusCode: code,
            );
          }
          if (code == 404) {
            return ApiException(
              ApiErrorKind.notFound,
              'We couldn’t find what you were looking for.',
              statusCode: code,
            );
          }
          return ApiException(
            ApiErrorKind.server,
            'Something went wrong on the server ($code).',
            statusCode: code,
          );
      }
    }
    return ApiException(ApiErrorKind.unknown, error.toString());
  }

  @override
  String toString() => 'ApiException($kind, $message)';
}
