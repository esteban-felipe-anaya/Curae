import 'package:freezed_annotation/freezed_annotation.dart';

part 'specialty.freezed.dart';
part 'specialty.g.dart';

@freezed
abstract class Specialty with _$Specialty {
  const factory Specialty({
    required String id,
    required String name,
    @Default('medical_services') String icon,
  }) = _Specialty;

  factory Specialty.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyFromJson(json);
}
