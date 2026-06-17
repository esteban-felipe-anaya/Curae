import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../features/auth/auth_controller.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/curae_image.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: CenteredContent(
        maxWidth: 600,
        child: ListView(
          padding: const EdgeInsets.all(AppTokens.space16),
          children: [
            if (user == null) ...[
              _GuestCard(),
              Gaps.v16,
            ] else ...[
              _ProfileHeader(user: user),
              Gaps.v16,
              if (user.insuranceProvider != null ||
                  user.bloodType != null)
                _InsuranceCard(user: user),
              Gaps.v16,
            ],
            _NavSection(isGuest: user == null),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Guest card
// ─────────────────────────────────────────────────────────────────────────────

class _GuestCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 48,
              color: scheme.onSurfaceVariant,
            ),
            Gaps.v12,
            Text(
              "You're browsing as a guest",
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Gaps.v8,
            Text(
              'Sign in to access your health records, appointments, and family members.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            Gaps.v16,
            FilledButton(
              onPressed: () => context.push(
                '${Routes.login}?from=${Uri.encodeComponent(Routes.account)}',
              ),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: AppTokens.space16,
                ),
                shape: const StadiumBorder(),
              ),
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Signed-in profile header
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  // Using dynamic type to avoid importing AppUser directly in a way
  // that causes lint — we receive the typed object from the parent.
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space20),
        child: Row(
          children: [
            CuraeAvatar(
              url: (user.avatar as String?) ?? '',
              radius: 36,
              fallback: user.name as String,
            ),
            Gaps.h16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name as String,
                    style: theme.textTheme.titleLarge,
                  ),
                  Gaps.v4,
                  Text(
                    user.email as String,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  if ((user.memberSince as String?) != null &&
                      (user.memberSince as String).isNotEmpty) ...[
                    Gaps.v4,
                    Text(
                      'Member since ${Fmt.monthYear(user.memberSince as String)}',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: scheme.primary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Insurance card
// ─────────────────────────────────────────────────────────────────────────────

class _InsuranceCard extends StatelessWidget {
  const _InsuranceCard({required this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final provider = (user.insuranceProvider as String?) ?? '';
    final rawNumber = (user.insuranceNumber as String?) ?? '';
    final maskedNumber = rawNumber.length > 4
        ? '${'*' * (rawNumber.length - 4)}${rawNumber.substring(rawNumber.length - 4)}'
        : rawNumber;
    final bloodType = (user.bloodType as String?) ?? '';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
        borderRadius: AppTokens.brXl,
      ),
      padding: const EdgeInsets.all(AppTokens.space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_outlined, color: scheme.primary, size: 20),
              Gaps.h8,
              Text(
                'Insurance',
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: scheme.primary),
              ),
              const Spacer(),
              if (bloodType.isNotEmpty)
                Chip(
                  label: Text(bloodType),
                  side: BorderSide.none,
                  backgroundColor:
                      scheme.errorContainer.withValues(alpha: 0.5),
                  labelStyle: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onErrorContainer,
                    fontWeight: FontWeight.w700,
                  ),
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
          Gaps.v12,
          if (provider.isNotEmpty) ...[
            Text(
              provider,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: scheme.onPrimaryContainer),
            ),
            Gaps.v4,
          ],
          if (maskedNumber.isNotEmpty)
            Text(
              maskedNumber,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                letterSpacing: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Navigation section (tiles in Cards)
// ─────────────────────────────────────────────────────────────────────────────

class _NavSection extends ConsumerWidget {
  const _NavSection({required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Column(
        children: [
          if (!isGuest) ...[
            ListTile(
              leading: const Icon(Icons.family_restroom_outlined),
              title: const Text('Family members'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(Routes.family),
            ),
            const Divider(height: 1, indent: AppTokens.space16),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(Routes.notifications),
            ),
            const Divider(height: 1, indent: AppTokens.space16),
          ],
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.settings),
          ),
          const Divider(height: 1, indent: AppTokens.space16),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.about),
          ),
          if (!isGuest) ...[
            const Divider(height: 1, indent: AppTokens.space16),
            ListTile(
              leading: Icon(Icons.logout, color: scheme.error),
              title: Text(
                'Log out',
                style: TextStyle(color: scheme.error),
              ),
              onTap: () => _confirmLogout(context, ref),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'You will be signed out of your account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(authControllerProvider.notifier).logout();
              if (context.mounted) context.go(Routes.home);
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
