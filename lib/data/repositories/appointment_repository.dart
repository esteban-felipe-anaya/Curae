import '../../core/network/api_exception.dart';
import '../api/curae_api.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';

class AppointmentRepository {
  AppointmentRepository(this._api);

  final CuraeApi _api;

  Future<List<Appointment>> all() async {
    try {
      final list = await _api.appointments(
        queries: {'_sort': 'date', '_order': 'desc'},
      );
      return list;
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Appointment> byId(String id) async {
    try {
      return await _api.appointment(id);
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Appointment> book({
    required Doctor doctor,
    required String patientId,
    required String patientName,
    required String date,
    required String slot,
    required AppointmentType type,
    required String reason,
  }) async {
    try {
      return await _api.createAppointment({
        'doctorId': doctor.id,
        'doctorName': doctor.name,
        'doctorPhoto': doctor.photo,
        'specialty': doctor.specialty,
        'patientId': patientId,
        'patientName': patientName,
        'date': date,
        'slot': slot,
        'type': type.wire,
        'reason': reason,
        'status': 'upcoming',
        'fee': doctor.fee,
        'currency': doctor.currency,
      });
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Appointment> reschedule(String id, String date, String slot) async {
    try {
      return await _api.patchAppointment(id, {'date': date, 'slot': slot});
    } catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<Appointment> cancel(String id) async {
    try {
      return await _api.patchAppointment(id, {'status': 'cancelled'});
    } catch (e) {
      throw ApiException.from(e);
    }
  }
}
