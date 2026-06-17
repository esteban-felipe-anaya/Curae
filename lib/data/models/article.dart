import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    @Default('') String excerpt,
    @Default('') String image,
    @Default('') String body,
    @Default('Curae Health Team') String author,
    @Default('') String date,
    @JsonKey(name: 'readMinutes') @Default(3) int readMinutes,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
