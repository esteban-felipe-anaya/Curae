import '../../core/network/api_exception.dart';
import '../api/curae_api.dart';
import '../api/doctor_query.dart';
import '../api/paged_result.dart';
import '../models/doctor.dart';
import '../models/review.dart';
import '../models/slot.dart';
import '../models/specialty.dart';

class DoctorRepository {
  DoctorRepository(this._api);

  final CuraeApi _api;

  Future<List<Specialty>> specialties() async {
    try {
      return await _api.specialties();
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<PagedResult<Doctor>> search(DoctorQuery query) async {
    try {
      final res = await _api.doctors(queries: query.toQueryParameters());
      final total = int.tryParse(
            res.response.headers.value('x-total-count') ?? '',
          ) ??
          res.data.length;
      return PagedResult(
        items: res.data,
        total: total,
        page: query.page,
        pageSize: query.limit,
      );
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Doctor> byId(String id) async {
    try {
      return await _api.doctor(id);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<List<Review>> reviews(String doctorId) async {
    try {
      return await _api.reviews(doctorId);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<List<DaySlots>> slots(String doctorId) async {
    try {
      return await _api.slots(doctorId);
    } catch (e) {
      throw ApiException.from(e);
    }
  }
}
