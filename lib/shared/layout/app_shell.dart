import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/router/routes.dart';
import '../../features/notifications/notification_providers.dart';

class _Dest {
  const _Dest(this.icon, this.selectedIcon, this.label);
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const _destinations = [
  _Dest(Icons.home_outlined, Icons.home, 'Home'),
  _Dest(Icons.search_outlined, Icons.search, 'Doctors'),
  _Dest(Icons.event_outlined, Icons.event, 'Appointments'),
  _Dest(Icons.favorite_outline, Icons.favorite, 'Records'),
  _Dest(Icons.person_outline, Icons.person, 'Account'),
];

/// Adaptive navigation shell: NavigationBar on phones (<600dp),
/// NavigationRail on tablets (600–840dp), and an extended rail on
/// desktop/web (>840dp). Hosts the [StatefulNavigationShell] tab content.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _go(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final index = navigationShell.currentIndex;

    if (width >= AppTokens.breakpointMedium) {
      final extended = width >= AppTokens.breakpointExpanded;
      return Scaffold(
        body: Row(
          children: [
            _Rail(
              extended: extended,
              selectedIndex: index,
              onSelected: _go,
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: _go,
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _Rail extends ConsumerWidget {
  const _Rail({
    required this.extended,
    required this.selectedIndex,
    required this.onSelected,
  });

  final bool extended;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final unread = ref.watch(unreadCountProvider);
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
        child: IntrinsicHeight(
          child: NavigationRail(
            extended: extended,
            selectedIndex: selectedIndex,
            onDestinationSelected: onSelected,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTokens.space16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.health_and_safety, color: theme.colorScheme.primary),
                  if (extended) ...[
                    Gaps.h8,
                    Text('Curae',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: theme.colorScheme.primary)),
                  ],
                ],
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.space16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Notifications',
                        onPressed: () => context.push(Routes.notifications),
                        icon: Badge.count(
                          isLabelVisible: unread > 0,
                          count: unread,
                          child: const Icon(Icons.notifications_outlined),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Settings',
                        onPressed: () => context.push(Routes.settings),
                        icon: const Icon(Icons.settings_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            destinations: [
              for (final d in _destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Constrains very wide desktop content to a comfortable reading width.
class CenteredContent extends StatelessWidget {
  const CenteredContent({super.key, required this.child, this.maxWidth = AppTokens.maxContentWidth});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
