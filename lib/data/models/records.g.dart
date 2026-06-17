// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VitalReading _$VitalReadingFromJson(Map<String, dynamic> json) =>
    _VitalReading(
      date: json['date'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$VitalReadingToJson(_VitalReading instance) =>
    <String, dynamic>{'date': instance.date, 'value': instance.value};

_VitalSeries _$VitalSeriesFromJson(Map<String, dynamic> json) => _VitalSeries(
  type: json['type'] as String,
  unit: json['unit'] as String? ?? '',
  readings:
      (json['readings'] as List<dynamic>?)
          ?.map((e) => VitalReading.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <VitalReading>[],
);

Map<String, dynamic> _$VitalSeriesToJson(_VitalSeries instance) =>
    <String, dynamic>{
      'type': instance.type,
      'unit': instance.unit,
      'readings': instance.readings,
    };

_LabReport _$LabReportFromJson(Map<String, dynamic> json) => _LabReport(
  id: json['id'] as String,
  name: json['name'] as String,
  date: json['date'] as String? ?? '',
  status: json['status'] as String? ?? 'Normal',
  summary: json['summary'] as String? ?? '',
  ordering: json['ordering'] as String? ?? '',
);

Map<String, dynamic> _$LabReportToJson(_LabReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'status': instance.status,
      'summary': instance.summary,
      'ordering': instance.ordering,
    };

_Prescription _$PrescriptionFromJson(Map<String, dynamic> json) =>
    _Prescription(
      id: json['id'] as String,
      medication: json['medication'] as String,
      dosage: json['dosage'] as String? ?? '',
      frequency: json['frequency'] as String? ?? '',
      doctor: json['doctor'] as String? ?? '',
      date: json['date'] as String? ?? '',
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$PrescriptionToJson(_Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medication': instance.medication,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'doctor': instance.doctor,
      'date': instance.date,
      'active': instance.active,
    };

_HealthRecords _$HealthRecordsFromJson(Map<String, dynamic> json) =>
    _HealthRecords(
      vitals:
          (json['vitals'] as List<dynamic>?)
              ?.map((e) => VitalSeries.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VitalSeries>[],
      labs:
          (json['labs'] as List<dynamic>?)
              ?.map((e) => LabReport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LabReport>[],
      prescriptions:
          (json['prescriptions'] as List<dynamic>?)
              ?.map((e) => Prescription.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Prescription>[],
    );

Map<String, dynamic> _$HealthRecordsToJson(_HealthRecords instance) =>
    <String, dynamic>{
      'vitals': instance.vitals,
      'labs': instance.labs,
      'prescriptions': instance.prescriptions,
    };
