import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/records.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/states.dart';
import '../../shared/widgets/ui.dart';
import '../auth/auth_controller.dart';
import 'records_providers.dart';

class RecordsScreen extends ConsumerWidget {
  const RecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = ref.watch(isAuthenticatedProvider);

    if (!isAuth) {
      return Scaffold(
        body: EmptyView(
          title: 'Sign in to view records',
          icon: Icons.favorite_outline,
          action: FilledButton(
            onPressed: () => context.push(
              '${Routes.login}?from=${Uri.encodeComponent(Routes.records)}',
            ),
            child: const Text('Sign in'),
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Health records'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Vitals'),
              Tab(text: 'Labs'),
              Tab(text: 'Prescriptions'),
            ],
          ),
        ),
        body: AsyncView<HealthRecords>(
          value: ref.watch(recordsProvider),
          loading: () => const SkeletonList(count: 4, itemHeight: 220),
          onRetry: () => ref.invalidate(recordsProvider),
          data: (records) => TabBarView(
            children: [
              _VitalsTab(vitals: records.vitals),
              _LabsTab(labs: records.labs),
              _PrescriptionsTab(prescriptions: records.prescriptions),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Vitals tab ───────────────────────────────────────────────────────────────

class _VitalsTab extends StatelessWidget {
  const _VitalsTab({required this.vitals});
  final List<VitalSeries> vitals;

  @override
  Widget build(BuildContext context) {
    if (vitals.isEmpty) {
      return const EmptyView(
        title: 'No vitals recorded',
        icon: Icons.monitor_heart_outlined,
      );
    }
    return ListView(
      padding: const EdgeInsets.all(AppTokens.space16),
      children: [
        for (final series in vitals) ...[
          _VitalCard(series: series),
          Gaps.v12,
        ],
        const DemoDisclaimer(),
        Gaps.v16,
      ],
    );
  }
}

class _VitalCard extends StatelessWidget {
  const _VitalCard({required this.series});
  final VitalSeries series;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final readings = series.readings;
    final latest = readings.isNotEmpty ? readings.last.value : null;

    final spots = <FlSpot>[
      for (var i = 0; i < readings.length; i++)
        FlSpot(i.toDouble(), readings[i].value),
    ];

    final minY = readings.isEmpty
        ? 0.0
        : readings.map((r) => r.value).reduce((a, b) => a < b ? a : b);
    final maxY = readings.isEmpty
        ? 1.0
        : readings.map((r) => r.value).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.15;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '${series.type}${series.unit.isNotEmpty ? ' (${series.unit})' : ''}',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                if (latest != null) ...[
                  Text(
                    latest.toStringAsFixed(
                        latest.truncateToDouble() == latest ? 0 : 1),
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: scheme.primary, fontWeight: FontWeight.bold),
                  ),
                  if (series.unit.isNotEmpty) ...[
                    Gaps.h4,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        series.unit,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ],
              ],
            ),
            Gaps.v12,
            if (spots.length < 2)
              SizedBox(
                height: 180,
                child: Center(
                  child: Text(
                    'Not enough data to plot',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              SizedBox(
                height: 180,
                child: LineChart(
                  LineChartData(
                    minY: minY - padding,
                    maxY: maxY + padding,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: scheme.outlineVariant.withValues(alpha: 0.5),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, _) => Text(
                            value.toStringAsFixed(0),
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: readings.length <= 6,
                          reservedSize: 22,
                          getTitlesWidget: (value, _) {
                            final idx = value.toInt();
                            if (idx < 0 || idx >= readings.length) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              Fmt.dayMonth(readings[idx].date),
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: scheme.primary,
                        barWidth: 2.5,
                        dotData: FlDotData(
                          show: spots.length <= 8,
                          getDotPainter: (_, _, _, _) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: scheme.primary,
                            strokeWidth: 2,
                            strokeColor: scheme.surface,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: scheme.primary.withValues(alpha: 0.08),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Labs tab ─────────────────────────────────────────────────────────────────

class _LabsTab extends StatelessWidget {
  const _LabsTab({required this.labs});
  final List<LabReport> labs;

  @override
  Widget build(BuildContext context) {
    if (labs.isEmpty) {
      return const EmptyView(
        title: 'No lab reports',
        icon: Icons.science_outlined,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppTokens.space16),
      itemCount: labs.length,
      separatorBuilder: (_, _) => Gaps.v12,
      itemBuilder: (_, i) => _LabCard(report: labs[i]),
    );
  }
}

class _LabCard extends StatelessWidget {
  const _LabCard({required this.report});
  final LabReport report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final (Color bg, Color fg) = switch (report.status.toLowerCase()) {
      'normal' => (scheme.secondaryContainer, scheme.onSecondaryContainer),
      'borderline' || 'low' =>
        (const Color(0xFFFFF3E0), AppTokens.warning),
      _ => (scheme.errorContainer, scheme.onErrorContainer),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(report.name, style: theme.textTheme.titleSmall),
                ),
                Gaps.h8,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: AppTokens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: AppTokens.brSm,
                  ),
                  child: Text(
                    report.status,
                    style: theme.textTheme.labelSmall?.copyWith(color: fg),
                  ),
                ),
              ],
            ),
            if (report.summary.isNotEmpty) ...[
              Gaps.v8,
              Text(
                report.summary,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            Gaps.v8,
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 14, color: scheme.onSurfaceVariant),
                Gaps.h4,
                Text(
                  Fmt.dayMonth(report.date),
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                if (report.ordering.isNotEmpty) ...[
                  Gaps.h12,
                  Icon(Icons.person_outline,
                      size: 14, color: scheme.onSurfaceVariant),
                  Gaps.h4,
                  Text(
                    report.ordering,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Prescriptions tab ─────────────────────────────────────────────────────────

class _PrescriptionsTab extends StatelessWidget {
  const _PrescriptionsTab({required this.prescriptions});
  final List<Prescription> prescriptions;

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isEmpty) {
      return const EmptyView(
        title: 'No prescriptions',
        icon: Icons.medication_outlined,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppTokens.space16),
      itemCount: prescriptions.length,
      separatorBuilder: (_, _) => Gaps.v12,
      itemBuilder: (_, i) => _PrescriptionCard(rx: prescriptions[i]),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard({required this.rx});
  final Prescription rx;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTokens.space8),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: AppTokens.brMd,
                  ),
                  child: Icon(Icons.medication_outlined,
                      size: 22, color: scheme.onPrimaryContainer),
                ),
                Gaps.h12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rx.medication, style: theme.textTheme.titleSmall),
                      Gaps.v4,
                      Text(
                        '${rx.dosage}  ·  ${rx.frequency}',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Gaps.h8,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: AppTokens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: rx.active
                        ? scheme.primaryContainer
                        : scheme.surfaceContainerHighest,
                    borderRadius: AppTokens.brSm,
                  ),
                  child: Text(
                    rx.active ? 'Active' : 'Past',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: rx.active
                          ? scheme.onPrimaryContainer
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: AppTokens.space24),
            Row(
              children: [
                if (rx.doctor.isNotEmpty) ...[
                  Icon(Icons.person_outline,
                      size: 14, color: scheme.onSurfaceVariant),
                  Gaps.h4,
                  Text(
                    rx.doctor,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  Gaps.h12,
                ],
                if (rx.date.isNotEmpty) ...[
                  Icon(Icons.calendar_today_outlined,
                      size: 14, color: scheme.onSurfaceVariant),
                  Gaps.h4,
                  Text(
                    Fmt.dayMonth(rx.date),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

