import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

enum AppointmentType {
  @JsonValue('in_person')
  inPerson,
  @JsonValue('video')
  video,
}

enum AppointmentStatus {
  @JsonValue('upcoming')
  upcoming,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

extension AppointmentTypeX on AppointmentType {
  String get label =>
      this == AppointmentType.video ? 'Video consult' : 'In-person';
  String get wire => this == AppointmentType.video ? 'video' : 'in_person';
}

extension AppointmentStatusX on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }
}

@freezed
abstract class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String doctorId,
    @Default('') String doctorName,
    @Default('') String doctorPhoto,
    @Default('') String specialty,
    required String patientId,
    @Default('') String patientName,
    required String date,
    required String slot,
    @JsonKey(unknownEnumValue: AppointmentType.inPerson)
    @Default(AppointmentType.inPerson)
    AppointmentType type,
    @Default('') String reason,
    @JsonKey(unknownEnumValue: AppointmentStatus.upcoming)
    @Default(AppointmentStatus.upcoming)
    AppointmentStatus status,
    @Default(0) num fee,
    @Default('USD') String currency,
    String? createdAt,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}
