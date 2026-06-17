import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/doctor.dart';
import 'curae_image.dart';
import 'ui.dart';

/// Doctor list card (real photo, specialty, rating, fee). Tappable.
class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor, required this.onTap});

  final Doctor doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CuraeImage(
                url: doctor.photo,
                width: 72,
                height: 72,
                borderRadius: AppTokens.brMd,
              ),
              Gaps.h12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name,
                        style: theme.textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(doctor.specialty,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: scheme.primary)),
                    Gaps.v8,
                    Row(
                      children: [
                        RatingLabel(rating: doctor.rating, count: doctor.reviewCount),
                        Gaps.h12,
                        Icon(Icons.work_outline,
                            size: 14, color: scheme.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text('${doctor.experienceYears}y',
                            style: theme.textTheme.labelSmall),
                      ],
                    ),
                  ],
                ),
              ),
              Gaps.h8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Fmt.money(doctor.fee, doctor.currency),
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: scheme.primary)),
                  Text('per visit', style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Compact doctor tile for horizontal rails on Home.
class DoctorRailCard extends StatelessWidget {
  const DoctorRailCard({super.key, required this.doctor, required this.onTap});
  final Doctor doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppTokens.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CuraeImage(
                  url: doctor.photo,
                  width: double.infinity,
                  height: 110,
                  borderRadius: AppTokens.brMd,
                ),
                Gaps.v8,
                Text(doctor.name,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(doctor.specialty,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Gaps.v4,
                RatingLabel(rating: doctor.rating, count: doctor.reviewCount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
