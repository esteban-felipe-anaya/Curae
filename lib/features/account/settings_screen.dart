import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/ui.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: CenteredContent(
        maxWidth: 600,
        child: ListView(
          padding: const EdgeInsets.all(AppTokens.space16),
          children: [
            // ── Appearance ────────────────────────────────────────────────
            _SectionCard(
              title: 'Appearance',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.space16,
                      vertical: AppTokens.space8,
                    ),
                    child: Text(
                      'Theme',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTokens.space16,
                    ),
                    child: SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto_outlined),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.light_mode_outlined),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.dark_mode_outlined),
                        ),
                      ],
                      selected: {themeMode},
                      onSelectionChanged: (s) =>
                          ref.read(themeModeProvider.notifier).set(s.first),
                    ),
                  ),
                  const SizedBox(height: AppTokens.space16),
                ],
              ),
            ),
            Gaps.v16,

            // ── Language ──────────────────────────────────────────────────
            _SectionCard(
              title: 'Language',
              child: RadioGroup<Locale?>(
                groupValue: locale,
                onChanged: (v) => ref.read(localeProvider.notifier).set(v),
                child: Column(
                  children: [
                    RadioListTile<Locale?>(
                      title: const Text('System default'),
                      secondary: const Icon(Icons.language_outlined),
                      value: null,
                    ),
                    const Divider(height: 1, indent: AppTokens.space16),
                    RadioListTile<Locale?>(
                      title: const Text('English'),
                      secondary: const Text(
                        '🇺🇸',
                        style: TextStyle(fontSize: 20),
                      ),
                      value: const Locale('en'),
                    ),
                    const Divider(height: 1, indent: AppTokens.space16),
                    RadioListTile<Locale?>(
                      title: const Text('Español'),
                      secondary: const Text(
                        '🇪🇸',
                        style: TextStyle(fontSize: 20),
                      ),
                      value: const Locale('es'),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.v24,

            const DemoDisclaimer(compact: false),
            Gaps.v16,
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppTokens.space4,
            bottom: AppTokens.space8,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Card(child: child),
      ],
    );
  }
}
