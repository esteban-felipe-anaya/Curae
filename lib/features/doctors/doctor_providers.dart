import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/api/doctor_query.dart';
import '../../data/api/paged_result.dart';
import '../../data/models/doctor.dart';
import '../../data/models/review.dart';
import '../../data/models/slot.dart';
import '../../data/models/specialty.dart';

final specialtiesProvider = FutureProvider<List<Specialty>>(
  (ref) => ref.watch(doctorRepositoryProvider).specialties(),
);

/// The live filter/search/sort state driving the doctor list.
class DoctorQueryController extends Notifier<DoctorQuery> {
  @override
  DoctorQuery build() => const DoctorQuery();

  void setSearch(String q) => state = state.copyWith(q: q, page: 1);

  void setSpecialty(String? specialtyId) => state = specialtyId == null
      ? state.copyWith(clearSpecialty: true, page: 1)
      : state.copyWith(specialtyId: specialtyId, page: 1);

  void setSort(DoctorSort sort) => state = state.copyWith(sort: sort, page: 1);

  void setMinRating(double? rating) => state = rating == null
      ? state.copyWith(clearMinRating: true, page: 1)
      : state.copyWith(minRating: rating, page: 1);

  void setGender(String? gender) => state = gender == null
      ? state.copyWith(clearGender: true, page: 1)
      : state.copyWith(gender: gender, page: 1);

  void reset() => state = const DoctorQuery();
}

final doctorQueryProvider =
    NotifierProvider<DoctorQueryController, DoctorQuery>(DoctorQueryController.new);

/// Doctor list for the current [doctorQueryProvider]. Re-runs on any change.
final doctorSearchProvider = FutureProvider<PagedResult<Doctor>>((ref) {
  final query = ref.watch(doctorQueryProvider);
  return ref.watch(doctorRepositoryProvider).search(query);
});

/// Top-rated doctors for the Home rail.
final topDoctorsProvider = FutureProvider<List<Doctor>>((ref) async {
  final res = await ref.watch(doctorRepositoryProvider).search(
        const DoctorQuery(sort: DoctorSort.rating, limit: 8),
      );
  return res.items;
});

final doctorByIdProvider = FutureProvider.family<Doctor, String>(
  (ref, id) => ref.watch(doctorRepositoryProvider).byId(id),
);

final doctorReviewsProvider = FutureProvider.family<List<Review>, String>(
  (ref, id) => ref.watch(doctorRepositoryProvider).reviews(id),
);

final doctorSlotsProvider = FutureProvider.family<List<DaySlots>, String>(
  (ref, id) => ref.watch(doctorRepositoryProvider).slots(id),
);
