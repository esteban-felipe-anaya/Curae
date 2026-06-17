import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_tokens.dart';
import '../../shared/layout/app_shell.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: CenteredContent(
        maxWidth: 600,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wordmark + icon
              Icon(
                Icons.health_and_safety,
                size: 72,
                color: scheme.primary,
              ),
              Gaps.v12,
              Text(
                'Curae',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Gaps.v8,
              Text(
                'Version 1.0.0 (demo)',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
              Gaps.v24,

              // Description
              Text(
                'Curae is a telehealth demonstration app built on fully synthetic data. '
                'It showcases a modern Flutter + Riverpod architecture with Material 3 '
                'design, featuring doctor discovery, appointment booking, health records, '
                'family member management, and personalised notifications — all powered '
                'by a mock API with realistic-looking data.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Gaps.v24,

              // Disclaimer card
              Card(
                color: scheme.errorContainer.withValues(alpha: 0.3),
                child: Padding(
                  padding: const EdgeInsets.all(AppTokens.space16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: scheme.error,
                        size: 22,
                      ),
                      Gaps.h12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Demo — not medical advice',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: scheme.onErrorContainer,
                              ),
                            ),
                            Gaps.v8,
                            Text(
                              'Curae is a demonstration app using synthetic data. '
                              'Health content is general and illustrative and must '
                              'not be used for diagnosis or treatment. Always consult '
                              'a qualified healthcare professional for medical advice.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onErrorContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gaps.v24,

              // Credits
              Text(
                'Imagery: randomuser.me portraits & Unsplash.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              Gaps.v16,
            ],
          ),
        ),
      ),
    );
  }
}
