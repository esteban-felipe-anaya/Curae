// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DaySlots _$DaySlotsFromJson(Map<String, dynamic> json) => _DaySlots(
  date: json['date'] as String,
  slots:
      (json['slots'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$DaySlotsToJson(_DaySlots instance) => <String, dynamic>{
  'date': instance.date,
  'slots': instance.slots,
  'doctorId': instance.doctorId,
};
