import 'package:curae/data/models/appointment.dart';
import 'package:curae/data/models/doctor.dart';
import 'package:curae/features/booking/booking_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _doctor = Doctor(
  id: 'doc_001',
  name: 'Dr. Ana Reyes',
  specialtyId: 'spec_cardio',
  specialty: 'Cardiology',
  photo: 'https://randomuser.me/api/portraits/women/45.jpg',
  fee: 60,
  currency: 'USD',
);

void main() {
  group('BookingDraft', () {
    test('is incomplete until doctor, slot and patient are all set', () {
      const empty = BookingDraft();
      expect(empty.isComplete, isFalse);

      final withSlot = empty.copyWith(doctor: _doctor, date: '2026-07-01', slot: '10:00');
      expect(withSlot.hasSlot, isTrue);
      expect(withSlot.hasPatient, isFalse);
      expect(withSlot.isComplete, isFalse);

      final full = withSlot.copyWith(patientId: 'user_1', patientName: 'Alex');
      expect(full.hasPatient, isTrue);
      expect(full.isComplete, isTrue);
    });
  });

  group('BookingController', () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer());
    tearDown(() => container.dispose());

    test('selectSlot, setType, setPatient and setReason mutate the draft', () {
      final notifier = container.read(bookingControllerProvider.notifier);

      notifier.selectSlot('2026-07-01', '09:30');
      notifier.setType(AppointmentType.inPerson);
      notifier.setPatient('fam_2', 'Mateo Morgan');
      notifier.setReason('Annual check-up');

      final draft = container.read(bookingControllerProvider);
      expect(draft.date, '2026-07-01');
      expect(draft.slot, '09:30');
      expect(draft.type, AppointmentType.inPerson);
      expect(draft.patientId, 'fam_2');
      expect(draft.patientName, 'Mateo Morgan');
      expect(draft.reason, 'Annual check-up');
    });

    test('clear resets the draft to empty', () {
      final notifier = container.read(bookingControllerProvider.notifier);
      notifier.selectSlot('2026-07-01', '09:30');
      notifier.clear();
      expect(container.read(bookingControllerProvider).hasSlot, isFalse);
    });
  });
}
