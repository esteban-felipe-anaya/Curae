// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Doctor _$DoctorFromJson(Map<String, dynamic> json) => _Doctor(
  id: json['id'] as String,
  name: json['name'] as String,
  specialtyId: json['specialtyId'] as String,
  specialty: json['specialty'] as String,
  photo: json['photo'] as String,
  gender: json['gender'] as String? ?? 'male',
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  experienceYears: (json['experienceYears'] as num?)?.toInt() ?? 0,
  fee: json['fee'] as num? ?? 0,
  currency: json['currency'] as String? ?? 'USD',
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  location: json['location'] as String? ?? '',
  about: json['about'] as String? ?? '',
  bio: json['bio'] as String? ?? '',
);

Map<String, dynamic> _$DoctorToJson(_Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'specialtyId': instance.specialtyId,
  'specialty': instance.specialty,
  'photo': instance.photo,
  'gender': instance.gender,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'experienceYears': instance.experienceYears,
  'fee': instance.fee,
  'currency': instance.currency,
  'languages': instance.languages,
  'location': instance.location,
  'about': instance.about,
  'bio': instance.bio,
};
