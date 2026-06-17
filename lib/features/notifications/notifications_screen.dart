import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/notification.dart';
import '../../features/auth/auth_controller.dart';
import '../../shared/widgets/async_view.dart';
import '../../shared/widgets/states.dart';
import 'notification_providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuth = ref.watch(isAuthenticatedProvider);

    if (!isAuth) {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: EmptyView(
          title: 'Sign in to view notifications',
          message: 'Your appointment reminders and health updates will appear here.',
          icon: Icons.notifications_outlined,
          action: FilledButton(
            onPressed: () => context.push(
              '${Routes.login}?from=${Uri.encodeComponent(Routes.notifications)}',
            ),
            child: const Text('Sign in'),
          ),
        ),
      );
    }

    final notificationsAsync = ref.watch(notificationsProvider);
    final unread = ref.watch(unreadCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: unread > 0
                ? () => ref.read(notificationActionsProvider).markAllRead()
                : null,
            child: const Text('Mark all read'),
          ),
          const SizedBox(width: AppTokens.space4),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(notificationsProvider),
        child: AsyncView<List<AppNotification>>(
          value: notificationsAsync,
          onRetry: () => ref.invalidate(notificationsProvider),
          loading: () => const SkeletonList(count: 6, itemHeight: 80),
          data: (notifications) {
            if (notifications.isEmpty) {
              return const EmptyView(
                title: 'No notifications',
                message: "You're all caught up!",
                icon: Icons.notifications_none_outlined,
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppTokens.space8),
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final n = notifications[index];
                return _NotificationTile(
                  notification: n,
                  onTap: () =>
                      ref.read(notificationActionsProvider).markRead(n.id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

IconData _iconForType(String type) {
  switch (type) {
    case 'appointment':
      return Icons.event_outlined;
    case 'reminder':
      return Icons.alarm_outlined;
    case 'lab':
      return Icons.science_outlined;
    case 'article':
      return Icons.article_outlined;
    case 'prescription':
      return Icons.medication_outlined;
    case 'system':
    default:
      return Icons.info_outline;
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isUnread = !notification.read;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isUnread
            ? scheme.secondaryContainer.withValues(alpha: 0.4)
            : null,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space16,
          vertical: AppTokens.space12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type icon in a tonal container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isUnread
                    ? scheme.secondaryContainer
                    : scheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _iconForType(notification.type),
                size: 20,
                color: isUnread
                    ? scheme.onSecondaryContainer
                    : scheme.onSurfaceVariant,
              ),
            ),
            Gaps.h12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: isUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isUnread) ...[
                        Gaps.h8,
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (notification.body.isNotEmpty) ...[
                    Gaps.v4,
                    Text(
                      notification.body,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  Gaps.v4,
                  Text(
                    Fmt.relativeDay(notification.date),
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
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
