import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/appointment.dart';
import 'curae_image.dart';

/// Appointment summary card used in the list and Home hero.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment, required this.onTap});

  final Appointment appointment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final a = appointment;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CuraeAvatar(url: a.doctorPhoto, radius: 26, fallback: a.doctorName),
                  Gaps.h12,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(a.doctorName.isEmpty ? 'Doctor' : a.doctorName,
                            style: theme.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(a.specialty,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: scheme.primary)),
                      ],
                    ),
                  ),
                  _StatusChip(status: a.status),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppTokens.space12),
                child: Divider(height: 1),
              ),
              Row(
                children: [
                  _Meta(
                    icon: Icons.event_outlined,
                    label: Fmt.relativeDay(a.date),
                  ),
                  Gaps.h16,
                  _Meta(icon: Icons.schedule_outlined, label: Fmt.time(a.slot)),
                  const Spacer(),
                  Icon(
                    a.type == AppointmentType.video
                        ? Icons.videocam_outlined
                        : Icons.local_hospital_outlined,
                    size: 16,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(a.type.label, style: theme.textTheme.labelMedium),
                ],
              ),
              if (a.patientName.isNotEmpty) ...[
                Gaps.v8,
                Text('For ${a.patientName}',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: scheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (status) {
      AppointmentStatus.upcoming => (scheme.primaryContainer, scheme.onPrimaryContainer),
      AppointmentStatus.completed => (scheme.secondaryContainer, scheme.onSecondaryContainer),
      AppointmentStatus.cancelled => (scheme.errorContainer, scheme.onErrorContainer),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: AppTokens.brSm),
      child: Text(status.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg)),
    );
  }
}
