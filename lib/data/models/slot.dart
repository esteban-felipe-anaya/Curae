import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot.freezed.dart';
part 'slot.g.dart';

/// A single day's availability for a doctor: `{ date, slots: ["09:00", ...] }`.
@freezed
abstract class DaySlots with _$DaySlots {
  const factory DaySlots({
    required String date,
    @Default(<String>[]) List<String> slots,
    String? doctorId,
  }) = _DaySlots;

  factory DaySlots.fromJson(Map<String, dynamic> json) =>
      _$DaySlotsFromJson(json);
}
