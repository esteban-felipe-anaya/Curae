// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Specialty _$SpecialtyFromJson(Map<String, dynamic> json) => _Specialty(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String? ?? 'medical_services',
);

Map<String, dynamic> _$SpecialtyToJson(_Specialty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
    };
