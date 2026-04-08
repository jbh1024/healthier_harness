import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../providers/board_provider.dart';

class BoardListScreen extends ConsumerWidget {
  const BoardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(boardListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('게시판')),
      body: postsAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(boardListProvider),
        ),
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyState(
              message: '게시글이 없습니다',
              icon: Icons.forum_outlined,
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: post.isPinned
                      ? const Icon(Icons.push_pin, color: Colors.orange, size: 20)
                      : null,
                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('${post.authorName} | 조회 ${post.viewCount}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/board/${post.id}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/board/write'),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
