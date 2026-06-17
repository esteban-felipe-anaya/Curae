import 'dart:convert';
import 'dart:typed_data';

import 'package:curae/core/network/api_exception.dart';
import 'package:curae/data/api/curae_api.dart';
import 'package:curae/data/api/doctor_query.dart';
import 'package:curae/data/repositories/doctor_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal fake Dio adapter: returns canned responses without any network,
/// so the repository + retrofit deserialization + header parsing are tested.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this.handler);
  final ResponseBody Function(RequestOptions options) handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async =>
      handler(options);

  @override
  void close({bool force = false}) {}
}

Dio _dioReturning(ResponseBody Function(RequestOptions) handler) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local'));
  dio.httpClientAdapter = _FakeAdapter(handler);
  return dio;
}

ResponseBody _json(Object body, {int status = 200, Map<String, List<String>>? headers}) {
  return ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: {
      Headers.contentTypeHeader: const ['application/json'],
      ...?headers,
    },
  );
}

final _doctorsJson = [
  {
    'id': 'doc_001',
    'name': 'Dr. Ana Reyes',
    'specialtyId': 'spec_cardio',
    'specialty': 'Cardiology',
    'photo': 'https://randomuser.me/api/portraits/women/45.jpg',
    'rating': 4.8,
    'reviewCount': 132,
    'experienceYears': 12,
    'fee': 60,
    'currency': 'USD',
    'languages': ['English', 'Spanish'],
  },
  {
    'id': 'doc_002',
    'name': 'Dr. Luis Torres',
    'specialtyId': 'spec_gp',
    'specialty': 'General Practice',
    'photo': 'https://randomuser.me/api/portraits/men/32.jpg',
    'rating': 4.6,
    'reviewCount': 88,
    'experienceYears': 9,
    'fee': 40,
    'currency': 'USD',
  },
];

void main() {
  test('search() deserializes doctors and reads X-Total-Count', () async {
    late RequestOptions captured;
    final dio = _dioReturning((options) {
      captured = options;
      return _json(_doctorsJson, headers: {'x-total-count': ['30']});
    });
    final repo = DoctorRepository(CuraeApi(dio));

    final result = await repo.search(
      const DoctorQuery(specialtyId: 'spec_cardio', limit: 20),
    );

    expect(result.items, hasLength(2));
    expect(result.items.first.name, 'Dr. Ana Reyes');
    expect(result.total, 30);
    expect(result.pageSize, 20);
    expect(result.hasMore, isTrue); // 1 * 20 < 30
    // filter reached the wire as a query param
    expect(captured.queryParameters['specialtyId'], 'spec_cardio');
    expect(captured.queryParameters['_sort'], 'rating');
  });

  test('falls back to item count when X-Total-Count is missing', () async {
    final dio = _dioReturning((_) => _json(_doctorsJson));
    final repo = DoctorRepository(CuraeApi(dio));
    final result = await repo.search(const DoctorQuery());
    expect(result.total, 2);
  });

  test('maps a server 500 to a typed ApiException', () async {
    final dio = _dioReturning((_) => _json({'error': 'boom'}, status: 500));
    final repo = DoctorRepository(CuraeApi(dio));

    await expectLater(
      repo.search(const DoctorQuery()),
      throwsA(isA<ApiException>()
          .having((e) => e.kind, 'kind', ApiErrorKind.server)
          .having((e) => e.statusCode, 'statusCode', 500)),
    );
  });
}
