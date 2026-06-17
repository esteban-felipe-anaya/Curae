import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/article.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/states.dart';
import '../../shared/widgets/ui.dart';
import 'article_providers.dart';

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health tips'),
      ),
      body: CenteredContent(
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(articlesProvider),
          child: AsyncView<List<Article>>(
            value: articlesAsync,
            onRetry: () => ref.invalidate(articlesProvider),
            loading: () => const SkeletonList(count: 6, itemHeight: 220),
            data: (articles) {
              if (articles.isEmpty) {
                return const EmptyView(
                  title: 'No articles yet',
                  message: 'Check back soon for health tips.',
                  icon: Icons.article_outlined,
                );
              }

              final isWide = width >= AppTokens.breakpointMedium;
              final crossAxisCount = width >= AppTokens.breakpointExpanded ? 3 : 2;

              return Column(
                children: [
                  Expanded(
                    child: isWide
                        ? GridView.builder(
                            padding: const EdgeInsets.all(AppTokens.space16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: AppTokens.space16,
                              mainAxisSpacing: AppTokens.space16,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: articles.length,
                            itemBuilder: (_, index) => _ArticleCard(
                              article: articles[index],
                              onTap: () => context
                                  .push(Routes.articleDetail(articles[index].id)),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(AppTokens.space16),
                            itemCount: articles.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppTokens.space12),
                            itemBuilder: (_, index) => _ArticleCard(
                              article: articles[index],
                              onTap: () => context
                                  .push(Routes.articleDetail(articles[index].id)),
                            ),
                          ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(AppTokens.space16),
                    child: DemoDisclaimer(compact: true),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article, required this.onTap});

  final Article article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CuraeImage(
                url: article.image,
                fit: BoxFit.cover,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTokens.radiusMd),
                  topRight: Radius.circular(AppTokens.radiusMd),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTokens.space12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: theme.textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.v8,
                  Text(
                    article.excerpt,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.v8,
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        size: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppTokens.space4),
                      Text(
                        '${article.readMinutes} min read',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: AppTokens.space8),
                      Text(
                        '·',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: AppTokens.space8),
                      Expanded(
                        child: Text(
                          Fmt.dayMonth(article.date),
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
