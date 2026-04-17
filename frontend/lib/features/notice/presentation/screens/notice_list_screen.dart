import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../providers/notice_provider.dart';

class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesAsync = ref.watch(noticeListProvider);
    final isAdmin =
        ref.watch(currentAcademyProvider).role == 'ACADEMY_ADMIN';

    return Scaffold(
      appBar: AppBar(title: const Text('공지사항')),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () => context.push('/notices/write'),
              child: const Icon(Icons.edit),
            )
          : null,
      body: noticesAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(noticeListProvider),
        ),
        data: (notices) {
          if (notices.isEmpty) {
            return const EmptyState(
              message: '공지사항이 없습니다',
              icon: Icons.campaign_outlined,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              final notice = notices[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: notice.isImportant
                      ? const Icon(Icons.priority_high, color: Colors.red, size: 20)
                      : null,
                  title: Text(
                    notice.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: notice.isImportant
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : null,
                  ),
                  subtitle: Text('${notice.authorName} | 조회 ${notice.viewCount}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/notices/${notice.id}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
