import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/specialty.dart';
import '../../features/appointments/appointment_providers.dart';
import '../../features/articles/article_providers.dart';
import '../../features/auth/auth_controller.dart';
import '../../features/doctors/doctor_providers.dart';
import '../../features/notifications/notification_providers.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/appointment_card.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/doctor_card.dart';
import '../../shared/widgets/states.dart';
import '../../shared/widgets/ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final unread = ref.watch(unreadCountProvider);

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    final firstName = user?.name.split(' ').first ?? 'Welcome';
    final greetingTitle = user != null ? '$greeting, $firstName' : greeting;
    final avatarUrl = user?.avatar ?? '';

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppTokens.space16,
        title: Text(greetingTitle),
        leading: GestureDetector(
          onTap: () => context.push(Routes.account),
          child: Padding(
            padding: const EdgeInsets.only(left: AppTokens.space12),
            child: CuraeAvatar(
              url: avatarUrl,
              radius: 18,
              fallback: user?.name,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => context.push(Routes.notifications),
            icon: Badge.count(
              isLabelVisible: unread > 0,
              count: unread,
              child: const Icon(Icons.notifications_outlined),
            ),
          ),
          const SizedBox(width: AppTokens.space4),
        ],
      ),
      body: CenteredContent(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(topDoctorsProvider);
            ref.invalidate(articlesProvider);
            ref.invalidate(appointmentsProvider);
            ref.invalidate(specialtiesProvider);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.space16,
              vertical: AppTokens.space8,
            ),
            children: [
              // ── 1. Quick actions ──────────────────────────────────────
              _QuickActions(),
              Gaps.v24,

              // ── 2. Upcoming appointment ───────────────────────────────
              _UpcomingSection(),
              Gaps.v24,

              // ── 3. Specialties ────────────────────────────────────────
              SectionHeader(
                title: 'Specialties',
                onAction: () => context.go(Routes.doctors),
              ),
              Gaps.v12,
              _SpecialtiesRow(),
              Gaps.v24,

              // ── 4. Top doctors ────────────────────────────────────────
              SectionHeader(
                title: 'Top doctors',
                onAction: () => context.go(Routes.doctors),
              ),
              Gaps.v12,
              _TopDoctorsRow(),
              Gaps.v24,

              // ── 5. Health tips ────────────────────────────────────────
              SectionHeader(
                title: 'Health tips',
                onAction: () => context.push(Routes.articles),
              ),
              Gaps.v12,
              _HealthTipsRow(),
              Gaps.v24,

              // ── 6. Demo disclaimer ────────────────────────────────────
              const Padding(
                padding: EdgeInsets.only(bottom: AppTokens.space16),
                child: DemoDisclaimer(compact: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick actions
// ─────────────────────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionTile(
          icon: Icons.calendar_month_outlined,
          label: 'Book',
          onTap: () => context.go(Routes.doctors),
        ),
        const SizedBox(width: AppTokens.space8),
        _ActionTile(
          icon: Icons.videocam_outlined,
          label: 'Consult',
          onTap: () => context.go(Routes.doctors),
        ),
        const SizedBox(width: AppTokens.space8),
        _ActionTile(
          icon: Icons.folder_outlined,
          label: 'Records',
          onTap: () => context.go(Routes.records),
        ),
        const SizedBox(width: AppTokens.space8),
        _ActionTile(
          icon: Icons.local_pharmacy_outlined,
          label: 'Pharmacy',
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pharmacy is coming soon')),
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTokens.brLg,
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: AppTokens.brLg,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppTokens.space16,
            horizontal: AppTokens.space8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: scheme.onSecondaryContainer, size: 28),
              const SizedBox(height: AppTokens.space4),
              Text(
                label,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: scheme.onSecondaryContainer),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Upcoming appointment section
// ─────────────────────────────────────────────────────────────────────────────

class _UpcomingSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final next = ref.watch(nextAppointmentProvider);

    if (next != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Upcoming'),
          Gaps.v12,
          AppointmentCard(
            appointment: next,
            onTap: () => context.push(Routes.appointmentDetail(next.id)),
          ),
        ],
      );
    }

    return _NoAppointmentCard();
  }
}

class _NoAppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Card(
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTokens.space12),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: AppTokens.brMd,
              ),
              child: Icon(
                Icons.event_outlined,
                color: scheme.onPrimaryContainer,
                size: 28,
              ),
            ),
            Gaps.h16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No upcoming appointments',
                    style: theme.textTheme.titleSmall,
                  ),
                  Gaps.v4,
                  Text(
                    'Schedule a visit with a doctor today.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  Gaps.v12,
                  FilledButton(
                    onPressed: () => context.go(Routes.doctors),
                    child: const Text('Find a doctor'),
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

// ─────────────────────────────────────────────────────────────────────────────
// Specialties horizontal row
// ─────────────────────────────────────────────────────────────────────────────

class _SpecialtiesRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialtiesAsync = ref.watch(specialtiesProvider);
    return AsyncView<List<Specialty>>(
      value: specialtiesAsync,
      onRetry: () => ref.invalidate(specialtiesProvider),
      loading: () => _SpecialtiesLoadingRow(),
      data: (specialties) => SizedBox(
        height: 96,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: specialties.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space8),
          itemBuilder: (_, index) {
            final s = specialties[index];
            return _SpecialtyTile(specialty: s);
          },
        ),
      ),
    );
  }
}

class _SpecialtyTile extends ConsumerWidget {
  const _SpecialtyTile({required this.specialty});

  final Specialty specialty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        ref.read(doctorQueryProvider.notifier).setSpecialty(specialty.id);
        context.go(Routes.doctors);
      },
      borderRadius: AppTokens.brLg,
      child: Ink(
        width: 80,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: AppTokens.brLg,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppTokens.space12,
          horizontal: AppTokens.space8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              specialtyIconData(specialty.icon),
              color: scheme.primary,
              size: 28,
            ),
            Gaps.v8,
            Text(
              specialty.name,
              style: theme.textTheme.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialtiesLoadingRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space8),
        itemBuilder: (_, _) => const SkeletonBox(
          width: 80,
          height: 96,
          radius: AppTokens.radiusLg,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Top doctors horizontal rail
// ─────────────────────────────────────────────────────────────────────────────

class _TopDoctorsRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(topDoctorsProvider);
    return AsyncView(
      value: doctorsAsync,
      onRetry: () => ref.invalidate(topDoctorsProvider),
      loading: () => _DoctorRailLoading(),
      data: (doctors) => SizedBox(
        height: 210,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: doctors.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space8),
          itemBuilder: (_, index) {
            final d = doctors[index];
            return DoctorRailCard(
              doctor: d,
              onTap: () => context.push(Routes.doctorDetail(d.id)),
            );
          },
        ),
      ),
    );
  }
}

class _DoctorRailLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space8),
        itemBuilder: (_, _) => const SkeletonBox(
          width: 160,
          height: 210,
          radius: AppTokens.radiusLg,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Health tips horizontal row
// ─────────────────────────────────────────────────────────────────────────────

class _HealthTipsRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    return AsyncView(
      value: articlesAsync,
      onRetry: () => ref.invalidate(articlesProvider),
      loading: () => _ArticleRowLoading(),
      data: (articles) => SizedBox(
        height: 192,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: articles.length,
          separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space12),
          itemBuilder: (_, index) {
            final a = articles[index];
            return _ArticleTile(
              imageUrl: a.image,
              title: a.title,
              readMinutes: a.readMinutes,
              onTap: () => context.push(Routes.articleDetail(a.id)),
            );
          },
        ),
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  const _ArticleTile({
    required this.imageUrl,
    required this.title,
    required this.readMinutes,
    required this.onTap,
  });

  final String imageUrl;
  final String title;
  final int readMinutes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return SizedBox(
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CuraeImage(
                url: imageUrl,
                width: 180,
                height: 110,
              ),
              Padding(
                padding: const EdgeInsets.all(AppTokens.space8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v4,
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppTokens.space2),
                        Text(
                          '$readMinutes min read',
                          style: theme.textTheme.labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleRowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 192,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(width: AppTokens.space12),
        itemBuilder: (_, _) => const SkeletonBox(
          width: 180,
          height: 192,
          radius: AppTokens.radiusLg,
        ),
      ),
    );
  }
}
