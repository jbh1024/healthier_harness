import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../data/notification_repository.dart';
import '../providers/notification_provider.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(notificationRepositoryProvider).markAllAsRead();
              ref.invalidate(notificationListProvider);
              ref.invalidate(unreadCountProvider);
            },
            child: const Text('모두 읽음'),
          ),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(notificationListProvider),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const EmptyState(
              message: '알림이 없습니다',
              icon: Icons.notifications_none,
            );
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final n = notifications[index];
              return ListTile(
                leading: Icon(
                  _typeIcon(n.type),
                  color: n.isRead ? Colors.grey : Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  n.title,
                  style: TextStyle(
                    fontWeight: n.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Text(n.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                tileColor: n.isRead ? null : Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.1),
                onTap: () async {
                  if (!n.isRead) {
                    await ref.read(notificationRepositoryProvider).markAsRead(n.id);
                    ref.invalidate(notificationListProvider);
                    ref.invalidate(unreadCountProvider);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'ENROLLMENT_REQUESTED':
      case 'ENROLLMENT_APPROVED':
      case 'ENROLLMENT_REJECTED':
      case 'ENROLLMENT_CANCELLED':
        return Icons.how_to_reg;
      case 'VACANCY_AVAILABLE':
        return Icons.event_available;
      case 'NOTICE_CREATED':
        return Icons.campaign;
      case 'COMMENT_CREATED':
        return Icons.comment;
      default:
        return Icons.notifications;
    }
  }
}
