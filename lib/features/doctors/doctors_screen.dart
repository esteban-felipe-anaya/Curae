import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/api/doctor_query.dart';
import '../../data/api/paged_result.dart';
import '../../data/models/doctor.dart';
import '../../data/models/specialty.dart';
import '../../shared/layout/app_shell.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/doctor_card.dart';
import '../../shared/widgets/states.dart';
import 'doctor_detail_screen.dart';
import 'doctor_providers.dart';

/// Find-a-doctor: search + filter + sort over [doctorSearchProvider], with a
/// responsive layout that becomes master-detail on desktop.
class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({super.key});

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  /// Selected doctor for the desktop detail pane. Null falls back to first.
  String? _selectedId;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(doctorQueryProvider.notifier).setSearch(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= AppTokens.breakpointExpanded;
    final searchAsync = ref.watch(doctorSearchProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Find a doctor')),
      body: Column(
        children: [
          _FilterBar(
            searchController: _searchController,
            onSearchChanged: _onSearchChanged,
          ),
          const Divider(height: 1),
          Expanded(
            child: AsyncView<PagedResult<Doctor>>(
              value: searchAsync,
              onRetry: () => ref.invalidate(doctorSearchProvider),
              loading: () => const SkeletonList(itemHeight: 96),
              data: (result) {
                final doctors = result.items;
                if (doctors.isEmpty) {
                  return const EmptyView(
                    title: 'No doctors found',
                    message: 'Try adjusting your search or filters.',
                    icon: Icons.search_off_outlined,
                  );
                }
                final total = result.total;
                if (isDesktop) {
                  return _MasterDetail(
                    doctors: doctors,
                    total: total,
                    selectedId: _selectedId ?? doctors.first.id,
                    onSelect: (id) => setState(() => _selectedId = id),
                  );
                }
                return _ResultsList(
                  doctors: doctors,
                  total: total,
                  width: width,
                  onRefresh: () async =>
                      ref.invalidate(doctorSearchProvider),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Search bar + specialty chips + sort control.
class _FilterBar extends ConsumerWidget {
  const _FilterBar({
    required this.searchController,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(doctorQueryProvider);
    final specialtiesAsync = ref.watch(specialtiesProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTokens.space16,
        AppTokens.space12,
        AppTokens.space16,
        AppTokens.space8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SearchBar(
                  controller: searchController,
                  hintText: 'Search doctors',
                  leading: const Icon(Icons.search),
                  onChanged: onSearchChanged,
                  trailing: [
                    if ((query.q ?? '').isNotEmpty)
                      IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          ref.read(doctorQueryProvider.notifier).setSearch('');
                        },
                      ),
                  ],
                ),
              ),
              Gaps.h8,
              _SortMenu(current: query.sort),
            ],
          ),
          Gaps.v12,
          SizedBox(
            height: 40,
            child: AsyncView<List<Specialty>>(
              value: specialtiesAsync,
              loading: () => const _ChipSkeletons(),
              data: (specialties) => ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: AppTokens.space8),
                    child: FilterChip(
                      label: const Text('All'),
                      selected: query.specialtyId == null,
                      onSelected: (_) =>
                          ref.read(doctorQueryProvider.notifier).setSpecialty(null),
                    ),
                  ),
                  for (final s in specialties)
                    Padding(
                      padding: const EdgeInsets.only(right: AppTokens.space8),
                      child: FilterChip(
                        label: Text(s.name),
                        selected: query.specialtyId == s.id,
                        onSelected: (selected) => ref
                            .read(doctorQueryProvider.notifier)
                            .setSpecialty(selected ? s.id : null),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SortMenu extends ConsumerWidget {
  const _SortMenu({required this.current});

  final DoctorSort current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuAnchor(
      menuChildren: [
        for (final sort in DoctorSort.values)
          MenuItemButton(
            leadingIcon: Icon(
              sort == current
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
            ),
            onPressed: () =>
                ref.read(doctorQueryProvider.notifier).setSort(sort),
            child: Text(sort.label),
          ),
      ],
      builder: (context, controller, _) => IconButton.filledTonal(
        tooltip: 'Sort: ${current.label}',
        icon: const Icon(Icons.sort),
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }
}

class _ChipSkeletons extends StatelessWidget {
  const _ChipSkeletons();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        Padding(
          padding: EdgeInsets.only(right: AppTokens.space8),
          child: SkeletonBox(width: 64, height: 32, radius: AppTokens.radiusPill),
        ),
        Padding(
          padding: EdgeInsets.only(right: AppTokens.space8),
          child: SkeletonBox(width: 96, height: 32, radius: AppTokens.radiusPill),
        ),
        Padding(
          padding: EdgeInsets.only(right: AppTokens.space8),
          child: SkeletonBox(width: 80, height: 32, radius: AppTokens.radiusPill),
        ),
        Padding(
          padding: EdgeInsets.only(right: AppTokens.space8),
          child: SkeletonBox(width: 88, height: 32, radius: AppTokens.radiusPill),
        ),
      ],
    );
  }
}

/// Phone list / tablet grid of results, with pull-to-refresh and a count header.
class _ResultsList extends StatelessWidget {
  const _ResultsList({
    required this.doctors,
    required this.total,
    required this.width,
    required this.onRefresh,
  });

  final List<Doctor> doctors;
  final int total;
  final double width;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final isTablet = width >= AppTokens.breakpointMedium;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CenteredContent(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.space16,
                AppTokens.space12,
                AppTokens.space16,
                AppTokens.space4,
              ),
              sliver: SliverToBoxAdapter(
                child: _CountLabel(total: total),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.space16,
                0,
                AppTokens.space16,
                AppTokens.space24,
              ),
              sliver: isTablet
                  ? SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 460,
                        mainAxisSpacing: AppTokens.space12,
                        crossAxisSpacing: AppTokens.space12,
                        mainAxisExtent: 116,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => DoctorCard(
                          doctor: doctors[i],
                          onTap: () => context
                              .push(Routes.doctorDetail(doctors[i].id)),
                        ),
                        childCount: doctors.length,
                      ),
                    )
                  : SliverList.separated(
                      itemCount: doctors.length,
                      separatorBuilder: (_, _) => Gaps.v12,
                      itemBuilder: (context, i) => DoctorCard(
                        doctor: doctors[i],
                        onTap: () =>
                            context.push(Routes.doctorDetail(doctors[i].id)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Desktop master-detail: list pane on the left, detail pane on the right.
class _MasterDetail extends StatelessWidget {
  const _MasterDetail({
    required this.doctors,
    required this.total,
    required this.selectedId,
    required this.onSelect,
  });

  final List<Doctor> doctors;
  final int total;
  final String selectedId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 360,
          child: ListView.separated(
            padding: const EdgeInsets.all(AppTokens.space16),
            itemCount: doctors.length + 1,
            separatorBuilder: (_, _) => Gaps.v12,
            itemBuilder: (context, i) {
              if (i == 0) return _CountLabel(total: total);
              final doctor = doctors[i - 1];
              final selected = doctor.id == selectedId;
              return _SelectableCard(
                selected: selected,
                child: DoctorCard(
                  doctor: doctor,
                  onTap: () => onSelect(doctor.id),
                ),
              );
            },
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTokens.space24),
            child: DoctorDetailView(doctorId: selectedId),
          ),
        ),
      ],
    );
  }
}

class _SelectableCard extends StatelessWidget {
  const _SelectableCard({required this.selected, required this.child});

  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (!selected) return child;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppTokens.brMd,
        border: Border.all(color: scheme.primary, width: 2),
      ),
      child: child,
    );
  }
}

class _CountLabel extends StatelessWidget {
  const _CountLabel({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      total == 1 ? '1 doctor' : '$total doctors',
      style: theme.textTheme.titleSmall
          ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
    );
  }
}
