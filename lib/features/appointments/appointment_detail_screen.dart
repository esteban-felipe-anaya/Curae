import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/appointment.dart';
import '../../data/models/slot.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/slot_chip.dart';
import '../../shared/widgets/states.dart';
import '../doctors/doctor_providers.dart';
import 'appointment_providers.dart';

// ── Public entry point: detail embedded in a Scaffold ───────────────────────

class AppointmentDetailScreen extends ConsumerWidget {
  const AppointmentDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointment')),
      body: CenteredContent(child: AppointmentDetailView(id: id)),
    );
  }
}

// ── Scrollable body (no Scaffold) — also used in master-detail ──────────────

class AppointmentDetailView extends ConsumerWidget {
  const AppointmentDetailView({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(appointmentByIdProvider(id));
    return AsyncView<Appointment>(
      value: async,
      loading: () => const SkeletonList(count: 6, itemHeight: 80),
      onRetry: () => ref.invalidate(appointmentByIdProvider(id)),
      data: (appt) => _DetailBody(appt: appt),
    );
  }
}

// ── Internal body ────────────────────────────────────────────────────────────

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.appt});

  final Appointment appt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isUpcoming = appt.status == AppointmentStatus.upcoming;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTokens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Doctor card ──────────────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.space16),
              child: Row(
                children: [
                  CuraeAvatar(
                    url: appt.doctorPhoto,
                    radius: 32,
                    fallback: appt.doctorName,
                  ),
                  Gaps.h16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appt.doctorName.isEmpty ? 'Doctor' : appt.doctorName,
                          style: theme.textTheme.titleMedium,
                        ),
                        if (appt.specialty.isNotEmpty) ...[
                          Gaps.v4,
                          Text(
                            appt.specialty,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: scheme.primary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _StatusChip(status: appt.status),
                ],
              ),
            ),
          ),
          Gaps.v16,

          // ── Details grid ────────────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.space16),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: Fmt.fullDate(appt.date),
                  ),
                  const Divider(height: AppTokens.space24),
                  _DetailRow(
                    icon: Icons.schedule_outlined,
                    label: 'Time',
                    value: Fmt.time(appt.slot),
                  ),
                  const Divider(height: AppTokens.space24),
                  _DetailRow(
                    icon: appt.type == AppointmentType.video
                        ? Icons.videocam_outlined
                        : Icons.local_hospital_outlined,
                    label: 'Type',
                    value: appt.type.label,
                  ),
                  const Divider(height: AppTokens.space24),
                  _DetailRow(
                    icon: Icons.person_outlined,
                    label: 'Patient',
                    value: appt.patientName.isEmpty ? '—' : appt.patientName,
                  ),
                  if (appt.reason.isNotEmpty) ...[
                    const Divider(height: AppTokens.space24),
                    _DetailRow(
                      icon: Icons.notes_outlined,
                      label: 'Reason',
                      value: appt.reason,
                    ),
                  ],
                  const Divider(height: AppTokens.space24),
                  _DetailRow(
                    icon: Icons.payments_outlined,
                    label: 'Fee',
                    value: Fmt.money(appt.fee, appt.currency),
                  ),
                ],
              ),
            ),
          ),
          Gaps.v24,

          // ── Actions ─────────────────────────────────────────────────────
          if (isUpcoming) ...[
            if (appt.type == AppointmentType.video)
              FilledButton.icon(
                onPressed: () => context.push(Routes.videoCall(appt.id)),
                icon: const Icon(Icons.videocam_outlined),
                label: const Text('Join video call'),
              ),
            Gaps.v12,
            OutlinedButton.icon(
              onPressed: () => _showRescheduleSheet(context, ref),
              icon: const Icon(Icons.edit_calendar_outlined),
              label: const Text('Reschedule'),
            ),
            Gaps.v8,
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => _showCancelDialog(context, ref),
              child: const Text('Cancel appointment'),
            ),
          ] else ...[
            FilledButton.icon(
              onPressed: () =>
                  context.push(Routes.doctorDetail(appt.doctorId)),
              icon: const Icon(Icons.event_outlined),
              label: const Text('Book again'),
            ),
          ],
          Gaps.v32,
        ],
      ),
    );
  }

  // ── Reschedule bottom sheet ──────────────────────────────────────────────

  void _showRescheduleSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _RescheduleSheet(appt: appt),
    );
  }

  // ── Cancel dialog ────────────────────────────────────────────────────────

  Future<void> _showCancelDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel appointment?'),
        content: const Text(
          'This will cancel your appointment. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Keep it'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Cancel appointment'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref.read(appointmentActionsProvider).cancel(appt.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment cancelled')),
      );
      if (context.canPop()) context.pop();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel: $e')),
      );
    }
  }
}

// ── Reschedule bottom sheet widget ──────────────────────────────────────────

class _RescheduleSheet extends ConsumerStatefulWidget {
  const _RescheduleSheet({required this.appt});
  final Appointment appt;

  @override
  ConsumerState<_RescheduleSheet> createState() => _RescheduleSheetState();
}

class _RescheduleSheetState extends ConsumerState<_RescheduleSheet> {
  String? _selectedDate;
  String? _selectedSlot;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slotsAsync = ref.watch(doctorSlotsProvider(widget.appt.doctorId));

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollCtrl) => Column(
        children: [
          // Handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTokens.space12),
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: _brPill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.space16),
            child: Row(
              children: [
                Text('Reschedule', style: theme.textTheme.titleLarge),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: AsyncView<List<DaySlots>>(
              value: slotsAsync,
              onRetry: () =>
                  ref.invalidate(doctorSlotsProvider(widget.appt.doctorId)),
              data: (days) => _SlotPicker(
                days: days,
                scrollController: scrollCtrl,
                selectedDate: _selectedDate,
                selectedSlot: _selectedSlot,
                onDateSelected: (d) =>
                    setState(() { _selectedDate = d; _selectedSlot = null; }),
                onSlotSelected: (s) => setState(() => _selectedSlot = s),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.space16),
              child: FilledButton(
                onPressed: (_selectedDate != null &&
                        _selectedSlot != null &&
                        !_saving)
                    ? () => _confirmReschedule(context)
                    : null,
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Confirm reschedule'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmReschedule(BuildContext context) async {
    setState(() => _saving = true);
    try {
      await ref
          .read(appointmentActionsProvider)
          .reschedule(widget.appt.id, _selectedDate!, _selectedSlot!);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment rescheduled')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reschedule: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

// ── Slot picker inside the sheet ─────────────────────────────────────────────

class _SlotPicker extends StatelessWidget {
  const _SlotPicker({
    required this.days,
    required this.scrollController,
    required this.selectedDate,
    required this.selectedSlot,
    required this.onDateSelected,
    required this.onSlotSelected,
  });

  final List<DaySlots> days;
  final ScrollController scrollController;
  final String? selectedDate;
  final String? selectedSlot;
  final ValueChanged<String> onDateSelected;
  final ValueChanged<String> onSlotSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (days.isEmpty) {
      return const EmptyView(
        title: 'No availability',
        message: 'No slots are available for this doctor.',
        icon: Icons.event_busy_outlined,
      );
    }
    final selectedDay = days
        .where((d) => d.date == selectedDate)
        .firstOrNull;

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(AppTokens.space16),
      children: [
        Text('Pick a date', style: theme.textTheme.titleSmall),
        Gaps.v12,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final day in days) ...[
                _DayChip(
                  date: day.date,
                  selected: day.date == selectedDate,
                  onTap: () => onDateSelected(day.date),
                ),
                Gaps.h8,
              ],
            ],
          ),
        ),
        if (selectedDay != null) ...[
          Gaps.v16,
          Text('Available times', style: theme.textTheme.titleSmall),
          Gaps.v12,
          Wrap(
            spacing: AppTokens.space8,
            runSpacing: AppTokens.space8,
            children: [
              for (final slot in selectedDay.slots)
                SlotChip(
                  time: slot,
                  selected: slot == selectedSlot,
                  onSelected: (v) { if (v) onSlotSelected(slot); },
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.date,
    required this.selected,
    required this.onTap,
  });

  final String date;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ChoiceChip(
      label: Text(Fmt.dayMonth(date)),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      selectedColor: scheme.primaryContainer,
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (status) {
      AppointmentStatus.upcoming =>
        (scheme.primaryContainer, scheme.onPrimaryContainer),
      AppointmentStatus.completed =>
        (scheme.secondaryContainer, scheme.onSecondaryContainer),
      AppointmentStatus.cancelled =>
        (scheme.errorContainer, scheme.onErrorContainer),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.space12,
        vertical: AppTokens.space4,
      ),
      decoration: BoxDecoration(color: bg, borderRadius: AppTokens.brSm),
      child: Text(
        status.label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: fg),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: scheme.primary),
        Gaps.h12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
              Gaps.v4,
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

const _brPill = BorderRadius.all(Radius.circular(AppTokens.radiusPill));
