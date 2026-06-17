/// Sort options exposed in the Find-a-doctor UI.
enum DoctorSort { rating, feeLowHigh, feeHighLow, experience }

extension DoctorSortX on DoctorSort {
  String get label {
    switch (this) {
      case DoctorSort.rating:
        return 'Top rated';
      case DoctorSort.feeLowHigh:
        return 'Fee: low to high';
      case DoctorSort.feeHighLow:
        return 'Fee: high to low';
      case DoctorSort.experience:
        return 'Most experienced';
    }
  }
}

/// Immutable description of a doctor search. Maps cleanly to json-server query
/// params (`specialtyId`, `q`, `rating_gte`, `gender`, `_sort`/`_order`,
/// `_page`/`_limit`). Pure + side-effect-free so it is unit-testable.
class DoctorQuery {
  const DoctorQuery({
    this.specialtyId,
    this.q,
    this.minRating,
    this.gender,
    this.sort = DoctorSort.rating,
    this.page = 1,
    this.limit = 20,
  });

  final String? specialtyId;
  final String? q;
  final double? minRating;
  final String? gender;
  final DoctorSort sort;
  final int page;
  final int limit;

  Map<String, dynamic> toQueryParameters() {
    final m = <String, dynamic>{'_page': page, '_limit': limit};
    if (specialtyId != null && specialtyId!.isNotEmpty) {
      m['specialtyId'] = specialtyId;
    }
    if (q != null && q!.trim().isNotEmpty) m['q'] = q!.trim();
    if (minRating != null && minRating! > 0) m['rating_gte'] = minRating;
    if (gender != null && gender!.isNotEmpty) m['gender'] = gender;
    switch (sort) {
      case DoctorSort.rating:
        m['_sort'] = 'rating';
        m['_order'] = 'desc';
        break;
      case DoctorSort.feeLowHigh:
        m['_sort'] = 'fee';
        m['_order'] = 'asc';
        break;
      case DoctorSort.feeHighLow:
        m['_sort'] = 'fee';
        m['_order'] = 'desc';
        break;
      case DoctorSort.experience:
        m['_sort'] = 'experienceYears';
        m['_order'] = 'desc';
        break;
    }
    return m;
  }

  DoctorQuery copyWith({
    String? specialtyId,
    bool clearSpecialty = false,
    String? q,
    double? minRating,
    bool clearMinRating = false,
    String? gender,
    bool clearGender = false,
    DoctorSort? sort,
    int? page,
    int? limit,
  }) {
    return DoctorQuery(
      specialtyId: clearSpecialty ? null : (specialtyId ?? this.specialtyId),
      q: q ?? this.q,
      minRating: clearMinRating ? null : (minRating ?? this.minRating),
      gender: clearGender ? null : (gender ?? this.gender),
      sort: sort ?? this.sort,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}
