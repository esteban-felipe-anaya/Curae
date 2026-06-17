// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Appointment _$AppointmentFromJson(Map<String, dynamic> json) => _Appointment(
  id: json['id'] as String,
  doctorId: json['doctorId'] as String,
  doctorName: json['doctorName'] as String? ?? '',
  doctorPhoto: json['doctorPhoto'] as String? ?? '',
  specialty: json['specialty'] as String? ?? '',
  patientId: json['patientId'] as String,
  patientName: json['patientName'] as String? ?? '',
  date: json['date'] as String,
  slot: json['slot'] as String,
  type:
      $enumDecodeNullable(
        _$AppointmentTypeEnumMap,
        json['type'],
        unknownValue: AppointmentType.inPerson,
      ) ??
      AppointmentType.inPerson,
  reason: json['reason'] as String? ?? '',
  status:
      $enumDecodeNullable(
        _$AppointmentStatusEnumMap,
        json['status'],
        unknownValue: AppointmentStatus.upcoming,
      ) ??
      AppointmentStatus.upcoming,
  fee: json['fee'] as num? ?? 0,
  currency: json['currency'] as String? ?? 'USD',
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$AppointmentToJson(_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'doctorPhoto': instance.doctorPhoto,
      'specialty': instance.specialty,
      'patientId': instance.patientId,
      'patientName': instance.patientName,
      'date': instance.date,
      'slot': instance.slot,
      'type': _$AppointmentTypeEnumMap[instance.type]!,
      'reason': instance.reason,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
      'fee': instance.fee,
      'currency': instance.currency,
      'createdAt': instance.createdAt,
    };

const _$AppointmentTypeEnumMap = {
  AppointmentType.inPerson: 'in_person',
  AppointmentType.video: 'video',
};

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.upcoming: 'upcoming',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
};
