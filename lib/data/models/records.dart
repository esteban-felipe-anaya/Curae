import 'package:freezed_annotation/freezed_annotation.dart';

part 'records.freezed.dart';
part 'records.g.dart';

@freezed
abstract class VitalReading with _$VitalReading {
  const factory VitalReading({
    required String date,
    required double value,
  }) = _VitalReading;

  factory VitalReading.fromJson(Map<String, dynamic> json) =>
      _$VitalReadingFromJson(json);
}

@freezed
abstract class VitalSeries with _$VitalSeries {
  const factory VitalSeries({
    required String type,
    @Default('') String unit,
    @Default(<VitalReading>[]) List<VitalReading> readings,
  }) = _VitalSeries;

  factory VitalSeries.fromJson(Map<String, dynamic> json) =>
      _$VitalSeriesFromJson(json);
}

@freezed
abstract class LabReport with _$LabReport {
  const factory LabReport({
    required String id,
    required String name,
    @Default('') String date,
    @Default('Normal') String status,
    @Default('') String summary,
    @Default('') String ordering,
  }) = _LabReport;

  factory LabReport.fromJson(Map<String, dynamic> json) =>
      _$LabReportFromJson(json);
}

@freezed
abstract class Prescription with _$Prescription {
  const factory Prescription({
    required String id,
    required String medication,
    @Default('') String dosage,
    @Default('') String frequency,
    @Default('') String doctor,
    @Default('') String date,
    @Default(true) bool active,
  }) = _Prescription;

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);
}

@freezed
abstract class HealthRecords with _$HealthRecords {
  const factory HealthRecords({
    @Default(<VitalSeries>[]) List<VitalSeries> vitals,
    @Default(<LabReport>[]) List<LabReport> labs,
    @Default(<Prescription>[]) List<Prescription> prescriptions,
  }) = _HealthRecords;

  factory HealthRecords.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordsFromJson(json);
}
