import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/appointment.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/states.dart';
import '../auth/auth_controller.dart';
import '../family/family_providers.dart';
import 'booking_controller.dart';

/// Review-and-confirm page for the in-progress [bookingControllerProvider]
/// draft. Handles the signed-out path, patient selection and the success view.
class BookingScreen extends ConsumerStatefulWidget {
  const BookingScreen({super.key});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _reasonController = TextEditingController();
  bool _submitting = false;
  bool _booked = false;
  Appointment? _result;

  @override
  void initState() {
    super.initState();
    _reasonController.text = ref.read(bookingControllerProvider).reason;
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(bookingControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book appointment')),
      body: _buildBody(draft),
    );
  }

  Widget _buildBody(BookingDraft draft) {
    if (_booked && _result != null) {
      return _SuccessView(appointment: _result!);
    }

    if (draft.doctor == null) {
      return EmptyView(
        title: 'No booking in progress',
        message: 'Start a booking from a doctor',
        icon: Icons.event_note_outlined,
        action: FilledButton(
          onPressed: () => context.go(Routes.doctors),
          child: const Text('Find a doctor'),
        ),
      );
    }

    return CenteredContent(
      maxWidth: 720,
      child: ListView(
        padding: const EdgeInsets.all(AppTokens.space16),
        children: [
          _SummaryCard(draft: draft),
          Gaps.v24,
          _PatientSection(draft: draft),
          Gaps.v24,
          Text('Reason for visit',
              style: Theme.of(context).textTheme.titleMedium),
          Gaps.v8,
          TextField(
            controller: _reasonController,
            minLines: 2,
            maxLines: 4,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              hintText: 'Briefly describe your symptoms or reason (optional)',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) =>
                ref.read(bookingControllerProvider.notifier).setReason(v),
          ),
          Gaps.v24,
          _ConfirmButton(
            draft: draft,
            submitting: _submitting,
            onConfirm: _confirm,
          ),
          Gaps.v16,
        ],
      ),
    );
  }

  Future<void> _confirm() async {
    if (!ref.read(isAuthenticatedProvider)) {
      context.push(
        '${Routes.login}?from=${Uri.encodeComponent(Routes.booking)}',
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      final appt = await ref.read(bookingControllerProvider.notifier).confirm();
      if (!mounted) return;
      setState(() {
        _booked = true;
        _result = appt;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not book: $e')),
      );
    }
  }
}

class _SummaryCard extends ConsumerWidget {
  const _SummaryCard({required this.draft});

  final BookingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final doctor = draft.doctor!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CuraeAvatar(
                  url: doctor.photo,
                  radius: 28,
                  fallback: doctor.name,
                ),
                Gaps.h12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name, style: theme.textTheme.titleMedium),
                      Text(
                        doctor.specialty,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
                Text(
                  Fmt.money(doctor.fee, doctor.currency),
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
              ],
            ),
            const Divider(height: AppTokens.space32),
            Row(
              children: [
                Icon(Icons.event_outlined,
                    size: 18, color: theme.colorScheme.onSurfaceVariant),
                Gaps.h8,
                Text(
                  '${Fmt.relativeDay(draft.date!)} · ${Fmt.time(draft.slot!)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Gaps.v12,
            SegmentedButton<AppointmentType>(
              segments: const [
                ButtonSegment(
                  value: AppointmentType.inPerson,
                  icon: Icon(Icons.person_outline),
                  label: Text('In-person'),
                ),
                ButtonSegment(
                  value: AppointmentType.video,
                  icon: Icon(Icons.videocam_outlined),
                  label: Text('Video'),
                ),
              ],
              selected: {draft.type},
              onSelectionChanged: (s) =>
                  ref.read(bookingControllerProvider.notifier).setType(s.first),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientSection extends ConsumerWidget {
  const _PatientSection({required this.draft});

  final BookingDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final signedIn = ref.watch(isAuthenticatedProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Who is this for?', style: theme.textTheme.titleMedium),
        Gaps.v8,
        if (!signedIn)
          Card(
            color: theme.colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(AppTokens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock_outline,
                          color: theme.colorScheme.onSurfaceVariant),
                      Gaps.h8,
                      Expanded(
                        child: Text(
                          'Sign in to choose a patient and confirm your booking.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v12,
                  FilledButton(
                    onPressed: () => context.push(
                      '${Routes.login}?from=${Uri.encodeComponent(Routes.booking)}',
                    ),
                    child: const Text('Sign in to continue'),
                  ),
                ],
              ),
            ),
          )
        else
          _PatientPicker(selectedId: draft.patientId),
      ],
    );
  }
}

class _PatientPicker extends ConsumerWidget {
  const _PatientPicker({required this.selectedId});

  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patients = ref.watch(patientsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in patients) ...[
          _PatientTile(
            patient: p,
            selected: p.id == selectedId,
            onTap: () => ref
                .read(bookingControllerProvider.notifier)
                .setPatient(p.id, p.name),
          ),
          Gaps.v8,
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => context.push(Routes.family),
            icon: const Icon(Icons.group_outlined),
            label: const Text('Manage family'),
          ),
        ),
      ],
    );
  }
}

class _PatientTile extends StatelessWidget {
  const _PatientTile({
    required this.patient,
    required this.selected,
    required this.onTap,
  });

  final Patient patient;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      color: selected ? scheme.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: AppTokens.brMd,
        side: selected
            ? BorderSide(color: scheme.primary, width: 1.5)
            : BorderSide(color: scheme.outlineVariant),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CuraeAvatar(
          url: patient.avatar,
          radius: 20,
          fallback: patient.name,
        ),
        title: Text(patient.name),
        subtitle: Text(patient.relation),
        trailing: Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: selected ? scheme.primary : scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton({
    required this.draft,
    required this.submitting,
    required this.onConfirm,
  });

  final BookingDraft draft;
  final bool submitting;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedIn = ref.watch(isAuthenticatedProvider);
    final enabled = draft.isComplete && signedIn && !submitting;

    return FilledButton.icon(
      onPressed: enabled ? () => onConfirm() : null,
      icon: submitting
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.check_circle_outline),
      label: Text(submitting ? 'Booking…' : 'Confirm booking'),
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
      ),
    );
  }
}

class _SuccessView extends ConsumerWidget {
  const _SuccessView({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return CenteredContent(
      maxWidth: 560,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.space24),
        child: Column(
          children: [
            Gaps.v32,
            CircleAvatar(
              radius: 44,
              backgroundColor: scheme.primaryContainer,
              child: Icon(Icons.check_rounded,
                  size: 52, color: scheme.onPrimaryContainer),
            ),
            Gaps.v24,
            Text('Appointment booked',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center),
            Gaps.v8,
            Text(
              'A confirmation has been added to your appointments.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            Gaps.v24,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CuraeAvatar(
                          url: appointment.doctorPhoto,
                          radius: 24,
                          fallback: appointment.doctorName,
                        ),
                        Gaps.h12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(appointment.doctorName,
                                  style: theme.textTheme.titleMedium),
                              if (appointment.specialty.isNotEmpty)
                                Text(
                                  appointment.specialty,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: scheme.primary),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: AppTokens.space32),
                    _SummaryLine(
                      icon: Icons.event_outlined,
                      text:
                          '${Fmt.relativeDay(appointment.date)} · ${Fmt.time(appointment.slot)}',
                    ),
                    Gaps.v8,
                    _SummaryLine(
                      icon: appointment.type == AppointmentType.video
                          ? Icons.videocam_outlined
                          : Icons.person_outline,
                      text: appointment.type.label,
                    ),
                    if (appointment.patientName.isNotEmpty) ...[
                      Gaps.v8,
                      _SummaryLine(
                        icon: Icons.person_pin_circle_outlined,
                        text: appointment.patientName,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Gaps.v24,
            FilledButton(
              onPressed: () {
                ref.read(bookingControllerProvider.notifier).clear();
                context.go(Routes.appointments);
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('View appointment'),
            ),
            Gaps.v8,
            OutlinedButton(
              onPressed: () {
                ref.read(bookingControllerProvider.notifier).clear();
                context.go(Routes.home);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        Gaps.h8,
        Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
      ],
    );
  }
}
