import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../data/notification_repository.dart';
import '../providers/notification_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('알림 설정')),
      body: settingsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(message: e.toString()),
        data: (settings) {
          return ListView(
            children: [
              SwitchListTile(
                title: const Text('수강 신청 알림'),
                subtitle: const Text('수강 신청/승인/거절/취소 알림'),
                value: settings.enrollmentNotify,
                onChanged: (v) async {
                  await ref.read(notificationRepositoryProvider)
                      .updateSettings(enrollmentNotify: v);
                  ref.invalidate(notificationSettingsProvider);
                },
              ),
              SwitchListTile(
                title: const Text('공지사항 알림'),
                subtitle: const Text('새 공지사항 등록 알림'),
                value: settings.noticeNotify,
                onChanged: (v) async {
                  await ref.read(notificationRepositoryProvider)
                      .updateSettings(noticeNotify: v);
                  ref.invalidate(notificationSettingsProvider);
                },
              ),
              SwitchListTile(
                title: const Text('댓글 알림'),
                subtitle: const Text('내 글에 댓글 알림'),
                value: settings.commentNotify,
                onChanged: (v) async {
                  await ref.read(notificationRepositoryProvider)
                      .updateSettings(commentNotify: v);
                  ref.invalidate(notificationSettingsProvider);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
