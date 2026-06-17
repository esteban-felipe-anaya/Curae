// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String,
  user: json['user'] as String,
  avatar: json['avatar'] as String? ?? '',
  rating: (json['rating'] as num?)?.toInt() ?? 0,
  comment: json['comment'] as String? ?? '',
  date: json['date'] as String? ?? '',
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'avatar': instance.avatar,
  'rating': instance.rating,
  'comment': instance.comment,
  'date': instance.date,
  'doctorId': instance.doctorId,
};
