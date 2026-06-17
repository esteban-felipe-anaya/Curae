import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/appointment.dart';
import '../../data/models/doctor.dart';
import '../appointments/appointment_providers.dart';
import '../auth/auth_controller.dart';

/// In-progress booking. Held by a [Notifier] so it survives navigation between
/// the doctor detail, slot, patient, reason and review steps.
class BookingDraft {
  const BookingDraft({
    this.doctor,
    this.date,
    this.slot,
    this.type = AppointmentType.video,
    this.patientId,
    this.patientName,
    this.reason = '',
  });

  final Doctor? doctor;
  final String? date;
  final String? slot;
  final AppointmentType type;
  final String? patientId;
  final String? patientName;
  final String reason;

  bool get hasSlot => date != null && slot != null;
  bool get hasPatient => (patientId ?? '').isNotEmpty;
  bool get isComplete => doctor != null && hasSlot && hasPatient;

  BookingDraft copyWith({
    Doctor? doctor,
    String? date,
    String? slot,
    AppointmentType? type,
    String? patientId,
    String? patientName,
    String? reason,
  }) {
    return BookingDraft(
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      slot: slot ?? this.slot,
      type: type ?? this.type,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      reason: reason ?? this.reason,
    );
  }
}

class BookingController extends Notifier<BookingDraft> {
  @override
  BookingDraft build() => const BookingDraft();

  /// Begin a booking for [doctor], defaulting the patient to the signed-in user.
  void start(Doctor doctor) {
    final user = ref.read(currentUserProvider);
    state = BookingDraft(
      doctor: doctor,
      type: AppointmentType.video,
      patientId: user?.id,
      patientName: user?.name,
    );
  }

  void selectSlot(String date, String slot) =>
      state = state.copyWith(date: date, slot: slot);

  void setType(AppointmentType type) => state = state.copyWith(type: type);

  void setPatient(String id, String name) =>
      state = state.copyWith(patientId: id, patientName: name);

  void setReason(String reason) => state = state.copyWith(reason: reason);

  void clear() => state = const BookingDraft();

  /// Persists the appointment and refreshes the appointments list.
  Future<Appointment> confirm() async {
    final d = state;
    if (d.doctor == null || !d.hasSlot || !d.hasPatient) {
      throw StateError('Booking draft is incomplete');
    }
    final appt = await ref.read(appointmentRepositoryProvider).book(
          doctor: d.doctor!,
          patientId: d.patientId!,
          patientName: d.patientName ?? '',
          date: d.date!,
          slot: d.slot!,
          type: d.type,
          reason: d.reason,
        );
    ref.invalidate(appointmentsProvider);
    return appt;
  }
}

final bookingControllerProvider =
    NotifierProvider<BookingController, BookingDraft>(BookingController.new);
