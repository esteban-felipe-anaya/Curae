import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';

/// Maps the API's specialty `icon` string to a Material icon.
IconData specialtyIconData(String key) {
  switch (key) {
    case 'favorite':
      return Icons.favorite_outline;
    case 'spa':
      return Icons.spa_outlined;
    case 'psychology':
      return Icons.psychology_outlined;
    case 'child_care':
      return Icons.child_care_outlined;
    case 'accessibility_new':
      return Icons.accessibility_new_outlined;
    case 'sentiment_satisfied':
      return Icons.sentiment_satisfied_outlined;
    case 'visibility':
      return Icons.visibility_outlined;
    case 'medical_services':
    default:
      return Icons.medical_services_outlined;
  }
}

/// Section title with an optional trailing action (e.g. "See all").
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onAction, this.actionLabel = 'See all'});

  final String title;
  final VoidCallback? onAction;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        if (onAction != null)
          TextButton(onPressed: onAction, child: Text(actionLabel)),
      ],
    );
  }
}

/// Small inline rating row (star + value + optional count).
class RatingLabel extends StatelessWidget {
  const RatingLabel({super.key, required this.rating, this.count});
  final double rating;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF5A623)),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1), style: theme.textTheme.labelLarge),
        if (count != null) ...[
          const SizedBox(width: 2),
          Text('($count)',
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ],
    );
  }
}

/// Subtle "Demo — not medical advice" banner.
class DemoDisclaimer extends StatelessWidget {
  const DemoDisclaimer({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space12, vertical: AppTokens.space8),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer.withValues(alpha: 0.5),
        borderRadius: AppTokens.brMd,
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: scheme.onTertiaryContainer),
          Gaps.h8,
          Expanded(
            child: Text(
              compact
                  ? 'Demo — not medical advice.'
                  : 'Demo app with synthetic data. Content is general and is not medical advice.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onTertiaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
