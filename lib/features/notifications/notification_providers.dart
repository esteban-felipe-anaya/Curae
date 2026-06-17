import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../data/models/notification.dart';

final notificationsProvider = FutureProvider<List<AppNotification>>(
  (ref) => ref.watch(contentRepositoryProvider).notifications(),
);

final unreadCountProvider = Provider<int>((ref) {
  final list = ref.watch(notificationsProvider).value ?? const [];
  return list.where((n) => !n.read).length;
});

class NotificationActions {
  NotificationActions(this.ref);
  final Ref ref;

  Future<void> markRead(String id) async {
    await ref.read(contentRepositoryProvider).markRead(id);
    ref.invalidate(notificationsProvider);
  }

  Future<void> markAllRead() async {
    final repo = ref.read(contentRepositoryProvider);
    final list = ref.read(notificationsProvider).value ?? const [];
    await Future.wait(
      list.where((n) => !n.read).map((n) => repo.markRead(n.id)),
    );
    ref.invalidate(notificationsProvider);
  }
}

final notificationActionsProvider =
    Provider<NotificationActions>((ref) => NotificationActions(ref));
