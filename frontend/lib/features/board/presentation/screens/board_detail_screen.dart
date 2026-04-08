import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/board_repository.dart';
import '../../domain/models/board_post.dart';
import '../providers/board_provider.dart';

class BoardDetailScreen extends ConsumerStatefulWidget {
  final int postId;

  const BoardDetailScreen({super.key, required this.postId});

  @override
  ConsumerState<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends ConsumerState<BoardDetailScreen> {
  final _commentController = TextEditingController();
  int? _replyToId;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final academy = ref.read(currentAcademyProvider).academy;
    if (academy == null) return;

    try {
      await ref.read(boardRepositoryProvider).createComment(
        academy.id,
        widget.postId,
        content: text,
        parentId: _replyToId,
      );
      _commentController.clear();
      setState(() => _replyToId = null);
      ref.invalidate(boardDetailProvider(widget.postId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(boardDetailProvider(widget.postId));

    return Scaffold(
      appBar: AppBar(title: const Text('게시글')),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(message: e.toString()),
        data: (post) {
          final rootComments = post.comments.where((c) => c.parentId == null).toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        '${post.authorName} | 조회 ${post.viewCount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Divider(height: 24),
                      Text(post.content),
                      const SizedBox(height: 24),
                      Text('댓글 ${post.comments.length}', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      ...rootComments.map((c) => _buildComment(c, post.comments)),
                    ],
                  ),
                ),
              ),
              _buildCommentInput(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildComment(Comment comment, List<Comment> allComments) {
    final replies = allComments.where((c) => c.parentId == comment.id).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(comment.content),
          subtitle: Text(comment.authorName),
          trailing: TextButton(
            onPressed: () => setState(() => _replyToId = comment.id),
            child: const Text('답글'),
          ),
        ),
        if (replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              children: replies.map((r) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(r.content),
                subtitle: Text(r.authorName),
              )).toList(),
            ),
          ),
        const Divider(),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_replyToId != null)
            Row(
              children: [
                const Icon(Icons.reply, size: 16),
                const SizedBox(width: 4),
                const Text('답글 작성 중'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => setState(() => _replyToId = null),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: '댓글을 입력하세요',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _submitComment,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
