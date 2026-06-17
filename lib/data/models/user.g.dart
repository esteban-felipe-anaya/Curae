// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  avatar: json['avatar'] as String?,
  dob: json['dob'] as String?,
  gender: json['gender'] as String?,
  bloodType: json['bloodType'] as String?,
  insuranceProvider: json['insuranceProvider'] as String?,
  insuranceNumber: json['insuranceNumber'] as String?,
  memberSince: json['memberSince'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'dob': instance.dob,
  'gender': instance.gender,
  'bloodType': instance.bloodType,
  'insuranceProvider': instance.insuranceProvider,
  'insuranceNumber': instance.insuranceNumber,
  'memberSince': instance.memberSince,
};

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      token: json['token'] as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

_MeResponse _$MeResponseFromJson(Map<String, dynamic> json) =>
    _MeResponse(user: AppUser.fromJson(json['user'] as Map<String, dynamic>));

Map<String, dynamic> _$MeResponseToJson(_MeResponse instance) =>
    <String, dynamic>{'user': instance.user};
