// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: json['id'] as String,
  title: json['title'] as String,
  excerpt: json['excerpt'] as String? ?? '',
  image: json['image'] as String? ?? '',
  body: json['body'] as String? ?? '',
  author: json['author'] as String? ?? 'Curae Health Team',
  date: json['date'] as String? ?? '',
  readMinutes: (json['readMinutes'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'excerpt': instance.excerpt,
  'image': instance.image,
  'body': instance.body,
  'author': instance.author,
  'date': instance.date,
  'readMinutes': instance.readMinutes,
};
