import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
abstract class Doctor with _$Doctor {
  const factory Doctor({
    required String id,
    required String name,
    required String specialtyId,
    required String specialty,
    required String photo,
    @Default('male') String gender,
    @Default(0) double rating,
    @JsonKey(name: 'reviewCount') @Default(0) int reviewCount,
    @JsonKey(name: 'experienceYears') @Default(0) int experienceYears,
    @Default(0) num fee,
    @Default('USD') String currency,
    @Default(<String>[]) List<String> languages,
    @Default('') String location,
    @Default('') String about,
    @Default('') String bio,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}
