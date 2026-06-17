import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/article.dart';

final articlesProvider = FutureProvider<List<Article>>(
  (ref) => ref.watch(contentRepositoryProvider).articles(),
);

final articleByIdProvider = FutureProvider.family<Article, String>((ref, id) async {
  final cached = ref.watch(articlesProvider).value?.where((a) => a.id == id).firstOrNull;
  if (cached != null) return cached;
  return ref.watch(contentRepositoryProvider).article(id);
});
