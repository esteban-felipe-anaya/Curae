// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) =>
    _FamilyMember(
      id: json['id'] as String,
      name: json['name'] as String,
      relation: json['relation'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      gender: json['gender'] as String? ?? 'male',
      avatar: json['avatar'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
    );

Map<String, dynamic> _$FamilyMemberToJson(_FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relation': instance.relation,
      'dob': instance.dob,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bloodType': instance.bloodType,
    };
