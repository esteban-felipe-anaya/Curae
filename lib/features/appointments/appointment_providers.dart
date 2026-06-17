import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/appointment.dart';

/// All appointments for the signed-in account (self + family), newest first.
final appointmentsProvider = FutureProvider<List<Appointment>>(
  (ref) => ref.watch(appointmentRepositoryProvider).all(),
);

final appointmentByIdProvider =
    FutureProvider.family<Appointment, String>((ref, id) async {
  // Prefer the already-loaded list to avoid a round-trip, fall back to fetch.
  final list = ref.watch(appointmentsProvider).value;
  final cached = list?.where((a) => a.id == id).firstOrNull;
  if (cached != null) return cached;
  return ref.watch(appointmentRepositoryProvider).byId(id);
});

/// Upcoming appointments (status upcoming, not in the past), soonest first.
final upcomingAppointmentsProvider = Provider<List<Appointment>>((ref) {
  final list = ref.watch(appointmentsProvider).value ?? const [];
  final items = list
      .where((a) => a.status == AppointmentStatus.upcoming)
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));
  return items;
});

final pastAppointmentsProvider = Provider<List<Appointment>>((ref) {
  final list = ref.watch(appointmentsProvider).value ?? const [];
  return list
      .where((a) => a.status != AppointmentStatus.upcoming)
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

/// The single next upcoming appointment, for the Home hero card.
final nextAppointmentProvider = Provider<Appointment?>(
  (ref) => ref.watch(upcomingAppointmentsProvider).firstOrNull,
);

/// Mutations (cancel / reschedule) that refresh the list afterwards.
class AppointmentActions {
  AppointmentActions(this.ref);
  final Ref ref;

  Future<void> cancel(String id) async {
    await ref.read(appointmentRepositoryProvider).cancel(id);
    ref.invalidate(appointmentsProvider);
  }

  Future<void> reschedule(String id, String date, String slot) async {
    await ref.read(appointmentRepositoryProvider).reschedule(id, date, slot);
    ref.invalidate(appointmentsProvider);
  }
}

final appointmentActionsProvider =
    Provider<AppointmentActions>((ref) => AppointmentActions(ref));
