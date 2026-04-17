import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/notice_repository.dart';
import '../providers/notice_provider.dart';

class NoticeDetailScreen extends ConsumerWidget {
  final int noticeId;

  const NoticeDetailScreen({super.key, required this.noticeId});

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('공지 삭제'),
        content: const Text('이 공지를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('취소'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    final academy = ref.read(currentAcademyProvider).academy;
    if (academy == null) return;

    try {
      await ref
          .read(noticeRepositoryProvider)
          .deleteNotice(academy.id, noticeId);
      ref.invalidate(noticeListProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('공지를 삭제했습니다')),
      );
      context.pop();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(noticeDetailProvider(noticeId));
    final isAdmin =
        ref.watch(currentAcademyProvider).role == 'ACADEMY_ADMIN';

    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항'),
        actions: isAdmin
            ? [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: '수정',
                  onPressed: () => context.push('/notices/$noticeId/edit'),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '삭제',
                  onPressed: () => _delete(context, ref),
                ),
              ]
            : null,
      ),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(message: e.toString()),
        data: (notice) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notice.isImportant)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '중요',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                Text(notice.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  '${notice.authorName} | 조회 ${notice.viewCount}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(height: 24),
                Text(notice.content),
              ],
            ),
          );
        },
      ),
    );
  }
}
