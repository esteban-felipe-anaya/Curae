import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/appointment.dart';
import '../../data/models/doctor.dart';
import '../../data/models/review.dart';
import '../../data/models/slot.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/curae_image.dart';
import '../../shared/widgets/slot_chip.dart';
import '../../shared/widgets/states.dart';
import '../../shared/widgets/ui.dart';
import '../booking/booking_controller.dart';
import 'doctor_providers.dart';

/// Reusable, scrollable doctor detail body (no Scaffold/AppBar). Used inline in
/// the desktop master-detail pane and inside [DoctorDetailScreen] on phones.
class DoctorDetailView extends ConsumerStatefulWidget {
  const DoctorDetailView({super.key, required this.doctorId});

  final String doctorId;

  @override
  ConsumerState<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends ConsumerState<DoctorDetailView> {
  AppointmentType _type = AppointmentType.video;
  DateTime? _selectedDay;
  String? _selectedSlot;

  static String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final doctorAsync = ref.watch(doctorByIdProvider(widget.doctorId));

    return AsyncView<Doctor>(
      value: doctorAsync,
      onRetry: () => ref.invalidate(doctorByIdProvider(widget.doctorId)),
      data: (doctor) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(doctor: doctor),
            Gaps.v24,
            _AboutSection(doctor: doctor),
            Gaps.v24,
            _SectionTitle('Consultation type'),
            Gaps.v8,
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
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            Gaps.v24,
            _SectionTitle('Availability'),
            Gaps.v8,
            _AvailabilitySection(
              doctorId: widget.doctorId,
              selectedDay: _selectedDay,
              selectedSlot: _selectedSlot,
              dayKey: _dayKey,
              onDaySelected: (day) => setState(() {
                _selectedDay = day;
                _selectedSlot = null;
              }),
              onDefaultDay: (day) {
                // Defer so we don't call setState during build.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _selectedDay == null) {
                    setState(() => _selectedDay = day);
                  }
                });
              },
              onSlotSelected: (slot) =>
                  setState(() => _selectedSlot = slot),
            ),
            Gaps.v24,
            _SectionTitle('Reviews'),
            Gaps.v8,
            _ReviewsSection(doctorId: widget.doctorId),
            Gaps.v24,
            FilledButton.icon(
              onPressed: (_selectedDay != null && _selectedSlot != null)
                  ? () => _book(context, doctor)
                  : null,
              icon: const Icon(Icons.event_available_outlined),
              label: const Text('Book appointment'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
            ),
            Gaps.v16,
          ],
        );
      },
    );
  }

  void _book(BuildContext context, Doctor doctor) {
    final dateIso = _dayKey(_selectedDay!);
    final n = ref.read(bookingControllerProvider.notifier);
    n.start(doctor);
    n.selectSlot(dateIso, _selectedSlot!);
    n.setType(_type);
    context.push(Routes.booking);
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final languages = doctor.languages.join(', ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CuraeImage(
          url: doctor.photo,
          width: 96,
          height: 96,
          borderRadius: AppTokens.brLg,
        ),
        Gaps.h16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctor.name, style: theme.textTheme.titleLarge),
              const SizedBox(height: 2),
              Text(
                doctor.specialty,
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: scheme.primary),
              ),
              Gaps.v8,
              if (doctor.location.isNotEmpty)
                _IconLine(
                  icon: Icons.place_outlined,
                  text: doctor.location,
                ),
              if (languages.isNotEmpty) ...[
                const SizedBox(height: 2),
                _IconLine(icon: Icons.translate, text: languages),
              ],
              Gaps.v8,
              Wrap(
                spacing: AppTokens.space16,
                runSpacing: AppTokens.space4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  RatingLabel(
                    rating: doctor.rating,
                    count: doctor.reviewCount,
                  ),
                  _IconLine(
                    icon: Icons.work_outline,
                    text: '${doctor.experienceYears} yrs exp',
                  ),
                  Text(
                    Fmt.money(doctor.fee, doctor.currency),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: scheme.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        Gaps.h4,
        Flexible(
          child: Text(
            text,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = doctor.about.isNotEmpty ? doctor.about : doctor.bio;
    if (text.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('About'),
        Gaps.v8,
        Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _AvailabilitySection extends ConsumerWidget {
  const _AvailabilitySection({
    required this.doctorId,
    required this.selectedDay,
    required this.selectedSlot,
    required this.dayKey,
    required this.onDaySelected,
    required this.onDefaultDay,
    required this.onSlotSelected,
  });

  final String doctorId;
  final DateTime? selectedDay;
  final String? selectedSlot;
  final String Function(DateTime) dayKey;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime> onDefaultDay;
  final ValueChanged<String> onSlotSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotsAsync = ref.watch(doctorSlotsProvider(doctorId));

    return AsyncView<List<DaySlots>>(
      value: slotsAsync,
      onRetry: () => ref.invalidate(doctorSlotsProvider(doctorId)),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppTokens.space24),
        child: SkeletonBox(height: 240, radius: AppTokens.radiusLg),
      ),
      data: (days) {
        final byDay = <DateTime, List<String>>{};
        for (final d in days) {
          final parsed = DateTime.tryParse(d.date);
          if (parsed == null || d.slots.isEmpty) continue;
          byDay[DateTime(parsed.year, parsed.month, parsed.day)] = d.slots;
        }

        if (byDay.isEmpty) {
          return const EmptyView(
            title: 'No availability',
            message: 'This doctor has no open slots right now.',
            icon: Icons.event_busy_outlined,
          );
        }

        final today = DateTime.now();
        final firstDay = DateTime(today.year, today.month, today.day);
        final lastDay = firstDay.add(const Duration(days: 30));

        // Default to the first available day if nothing selected yet.
        if (selectedDay == null) {
          final sorted = byDay.keys.toList()..sort();
          onDefaultDay(sorted.first);
        }

        final activeDay = selectedDay;
        final daySlots = activeDay == null
            ? const <String>[]
            : (byDay[DateTime(activeDay.year, activeDay.month, activeDay.day)] ??
                const <String>[]);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTokens.space8),
                child: TableCalendar<String>(
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: _clampFocused(
                    activeDay ?? firstDay,
                    firstDay,
                    lastDay,
                  ),
                  calendarFormat: CalendarFormat.twoWeeks,
                  availableCalendarFormats: const {
                    CalendarFormat.twoWeeks: '2 weeks',
                  },
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  enabledDayPredicate: (day) =>
                      byDay.containsKey(DateTime(day.year, day.month, day.day)),
                  selectedDayPredicate: (day) =>
                      activeDay != null && isSameDay(day, activeDay),
                  onDaySelected: (selected, _) => onDaySelected(
                    DateTime(selected.year, selected.month, selected.day),
                  ),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v16,
            if (daySlots.isEmpty)
              Text(
                'Select a day to see open times.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            else
              Wrap(
                spacing: AppTokens.space8,
                runSpacing: AppTokens.space8,
                children: [
                  for (final time in daySlots)
                    SlotChip(
                      time: time,
                      selected: time == selectedSlot,
                      onSelected: (_) => onSlotSelected(time),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }

  DateTime _clampFocused(DateTime day, DateTime first, DateTime last) {
    if (day.isBefore(first)) return first;
    if (day.isAfter(last)) return last;
    return day;
  }
}

class _ReviewsSection extends ConsumerWidget {
  const _ReviewsSection({required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(doctorReviewsProvider(doctorId));

    return AsyncView<List<Review>>(
      value: reviewsAsync,
      onRetry: () => ref.invalidate(doctorReviewsProvider(doctorId)),
      loading: () => const SkeletonBox(height: 120, radius: AppTokens.radiusLg),
      data: (reviews) {
        if (reviews.isEmpty) {
          return Text(
            'No reviews yet.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          );
        }
        final shown = reviews.take(4).toList();
        return Column(
          children: [
            for (final r in shown) ...[
              _ReviewTile(review: r),
              if (r != shown.last) Gaps.v8,
            ],
          ],
        );
      },
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CuraeAvatar(url: review.avatar, radius: 20, fallback: review.user),
            Gaps.h12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          review.user,
                          style: theme.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      RatingLabel(rating: review.rating.toDouble()),
                    ],
                  ),
                  if (review.comment.isNotEmpty) ...[
                    Gaps.v4,
                    Text(review.comment, style: theme.textTheme.bodySmall),
                  ],
                  if (review.date.isNotEmpty) ...[
                    Gaps.v4,
                    Text(
                      Fmt.dayMonth(review.date),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
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

/// Pushed route used on phones/tablets: wraps [DoctorDetailView] in a Scaffold.
class DoctorDetailScreen extends ConsumerWidget {
  const DoctorDetailScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsync = ref.watch(doctorByIdProvider(doctorId));
    final title = doctorAsync.value?.name ?? 'Doctor';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: CenteredContent(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.space16),
          child: DoctorDetailView(doctorId: doctorId),
        ),
      ),
    );
  }
}
