import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/states.dart';
import '../../shared/widgets/ui.dart';
import 'article_providers.dart';

class ArticleDetailScreen extends ConsumerWidget {
  const ArticleDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleAsync = ref.watch(articleByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: AsyncView(
        value: articleAsync,
        onRetry: () => ref.invalidate(articleByIdProvider(id)),
        loading: () => const _ArticleDetailSkeleton(),
        data: (article) => CenteredContent(
          maxWidth: 800,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image
                CuraeImage(
                  url: article.image,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(AppTokens.space20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Gaps.v12,
                      // Author · date · read time
                      _ArticleMeta(
                        author: article.author,
                        date: article.date,
                        readMinutes: article.readMinutes,
                      ),
                      Gaps.v24,
                      // Body paragraphs
                      _ArticleBody(body: article.body),
                      Gaps.v32,
                      // Disclaimer
                      const DemoDisclaimer(compact: false),
                      Gaps.v24,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArticleMeta extends StatelessWidget {
  const _ArticleMeta({
    required this.author,
    required this.date,
    required this.readMinutes,
  });

  final String author;
  final String date;
  final int readMinutes;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: scheme.onSurfaceVariant,
        );

    return Wrap(
      spacing: AppTokens.space8,
      runSpacing: AppTokens.space4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.person_outline, size: 14, color: scheme.onSurfaceVariant),
        Text(author, style: style),
        Text('·', style: style),
        Icon(Icons.calendar_today_outlined, size: 14, color: scheme.onSurfaceVariant),
        Text(Fmt.fullDate(date), style: style),
        Text('·', style: style),
        Icon(Icons.schedule_outlined, size: 14, color: scheme.onSurfaceVariant),
        Text('$readMinutes min read', style: style),
      ],
    );
  }
}

class _ArticleBody extends StatelessWidget {
  const _ArticleBody({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paragraphs = body
        .split('\n\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

    if (paragraphs.isEmpty) {
      return Text(body, style: theme.textTheme.bodyMedium);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < paragraphs.length; i++) ...[
          Text(paragraphs[i], style: theme.textTheme.bodyMedium),
          if (i < paragraphs.length - 1) Gaps.v16,
        ],
      ],
    );
  }
}

class _ArticleDetailSkeleton extends StatelessWidget {
  const _ArticleDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SkeletonList(count: 4, itemHeight: 120);
  }
}
