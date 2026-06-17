import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../shared/widgets/appointment_card.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/states.dart';
import '../auth/auth_controller.dart';
import 'appointment_detail_screen.dart';
import 'appointment_providers.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {
  // 0 = Upcoming, 1 = Past
  int _segment = 0;
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final isAuth = ref.watch(isAuthenticatedProvider);

    if (!isAuth) {
      return Scaffold(
        body: EmptyView(
          title: 'Sign in to view appointments',
          icon: Icons.event_outlined,
          action: FilledButton(
            onPressed: () => context.push(
              '${Routes.login}?from=${Uri.encodeComponent(Routes.appointments)}',
            ),
            child: const Text('Sign in'),
          ),
        ),
      );
    }

    final width = MediaQuery.sizeOf(context).width;
    final isExpanded = width >= AppTokens.breakpointExpanded;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.space16,
              0,
              AppTokens.space16,
              AppTokens.space8,
            ),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Upcoming'), icon: Icon(Icons.schedule_outlined)),
                ButtonSegment(value: 1, label: Text('Past'), icon: Icon(Icons.history_outlined)),
              ],
              selected: {_segment},
              onSelectionChanged: (s) => setState(() {
                _segment = s.first;
                _selectedId = null;
              }),
            ),
          ),
        ),
      ),
      body: isExpanded ? _buildMasterDetail(context) : _buildPhone(context),
    );
  }

  // ── Phone / narrow ──────────────────────────────────────────────────────────

  Widget _buildPhone(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(appointmentsProvider),
      child: AsyncView<List<dynamic>>(
        value: ref.watch(appointmentsProvider),
        loading: () => const SkeletonList(count: 5, itemHeight: 110),
        onRetry: () => ref.invalidate(appointmentsProvider),
        data: (_) => _segment == 0 ? _upcomingList(context) : _pastList(context),
      ),
    );
  }

  // ── Desktop master-detail ───────────────────────────────────────────────────

  Widget _buildMasterDetail(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 380,
          child: RefreshIndicator(
            onRefresh: () async => ref.invalidate(appointmentsProvider),
            child: AsyncView<List<dynamic>>(
              value: ref.watch(appointmentsProvider),
              loading: () => const SkeletonList(count: 5, itemHeight: 110),
              onRetry: () => ref.invalidate(appointmentsProvider),
              data: (_) => _segment == 0
                  ? _upcomingList(context, master: true)
                  : _pastList(context, master: true),
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _selectedId != null
              ? AppointmentDetailView(id: _selectedId!)
              : Center(
                  child: EmptyView(
                    title: 'Select an appointment',
                    message: 'Tap an appointment on the left to see details.',
                    icon: Icons.event_note_outlined,
                  ),
                ),
        ),
      ],
    );
  }

  // ── List builders ───────────────────────────────────────────────────────────

  Widget _upcomingList(BuildContext context, {bool master = false}) {
    final items = ref.watch(upcomingAppointmentsProvider);
    if (items.isEmpty) {
      return EmptyView(
        title: 'No upcoming appointments',
        icon: Icons.event_available_outlined,
        action: FilledButton(
          onPressed: () => context.go(Routes.doctors),
          child: const Text('Find a doctor'),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppTokens.space16),
      itemCount: items.length,
      separatorBuilder: (_, _) => Gaps.v12,
      itemBuilder: (_, i) {
        final a = items[i];
        return AppointmentCard(
          appointment: a,
          onTap: () {
            if (master) {
              setState(() => _selectedId = a.id);
            } else {
              context.push(Routes.appointmentDetail(a.id));
            }
          },
        );
      },
    );
  }

  Widget _pastList(BuildContext context, {bool master = false}) {
    final items = ref.watch(pastAppointmentsProvider);
    if (items.isEmpty) {
      return const EmptyView(
        title: 'No past appointments',
        icon: Icons.history_outlined,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppTokens.space16),
      itemCount: items.length,
      separatorBuilder: (_, _) => Gaps.v12,
      itemBuilder: (_, i) {
        final a = items[i];
        return AppointmentCard(
          appointment: a,
          onTap: () {
            if (master) {
              setState(() => _selectedId = a.id);
            } else {
              context.push(Routes.appointmentDetail(a.id));
            }
          },
        );
      },
    );
  }
}
