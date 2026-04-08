import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/notification_repository.dart';
import '../../domain/models/notification_model.dart';

final notificationListProvider =
    FutureProvider.autoDispose<List<AppNotification>>((ref) async {
  return ref.read(notificationRepositoryProvider).getNotifications();
});

final unreadCountProvider = FutureProvider.autoDispose<int>((ref) async {
  return ref.read(notificationRepositoryProvider).getUnreadCount();
});

final notificationSettingsProvider =
    FutureProvider.autoDispose<NotificationSettings>((ref) async {
  return ref.read(notificationRepositoryProvider).getSettings();
});
