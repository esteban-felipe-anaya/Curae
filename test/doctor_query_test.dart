import 'package:curae/data/api/doctor_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DoctorQuery -> json-server query params', () {
    test('defaults include pagination and rating sort', () {
      final q = const DoctorQuery().toQueryParameters();
      expect(q['_page'], 1);
      expect(q['_limit'], 20);
      expect(q['_sort'], 'rating');
      expect(q['_order'], 'desc');
      // unset filters are omitted
      expect(q.containsKey('specialtyId'), isFalse);
      expect(q.containsKey('q'), isFalse);
      expect(q.containsKey('rating_gte'), isFalse);
      expect(q.containsKey('gender'), isFalse);
    });

    test('maps every filter to its server param', () {
      final q = const DoctorQuery(
        specialtyId: 'spec_cardio',
        q: '  ana  ',
        minRating: 4.5,
        gender: 'female',
        sort: DoctorSort.feeLowHigh,
        page: 3,
        limit: 12,
      ).toQueryParameters();

      expect(q['specialtyId'], 'spec_cardio');
      expect(q['q'], 'ana'); // trimmed
      expect(q['rating_gte'], 4.5);
      expect(q['gender'], 'female');
      expect(q['_sort'], 'fee');
      expect(q['_order'], 'asc');
      expect(q['_page'], 3);
      expect(q['_limit'], 12);
    });

    test('blank/zero filters are dropped, not sent as empty', () {
      final q = const DoctorQuery(specialtyId: '', q: '   ', minRating: 0)
          .toQueryParameters();
      expect(q.containsKey('specialtyId'), isFalse);
      expect(q.containsKey('q'), isFalse);
      expect(q.containsKey('rating_gte'), isFalse);
    });

    test('sort variants map correctly', () {
      expect(const DoctorQuery(sort: DoctorSort.feeHighLow).toQueryParameters(),
          containsPair('_order', 'desc'));
      expect(const DoctorQuery(sort: DoctorSort.experience).toQueryParameters(),
          containsPair('_sort', 'experienceYears'));
    });

    test('copyWith can clear nullable filters', () {
      const base = DoctorQuery(specialtyId: 'spec_gp', minRating: 4, gender: 'male');
      final cleared = base.copyWith(
        clearSpecialty: true,
        clearMinRating: true,
        clearGender: true,
      );
      expect(cleared.specialtyId, isNull);
      expect(cleared.minRating, isNull);
      expect(cleared.gender, isNull);
    });
  });
}
