import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/board_repository.dart';
import '../providers/board_provider.dart';

class BoardWriteScreen extends ConsumerStatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  ConsumerState<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends ConsumerState<BoardWriteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final academy = ref.read(currentAcademyProvider).academy;
    if (academy == null) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(boardRepositoryProvider).createPost(
        academy.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
      );
      ref.invalidate(boardListProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 작성'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('등록'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: '제목',
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.titleLarge,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? '제목을 입력해주세요' : null,
              ),
              const Divider(),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요',
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? '내용을 입력해주세요' : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
