import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/notice_repository.dart';
import '../providers/notice_provider.dart';

class NoticeWriteScreen extends ConsumerStatefulWidget {
  final int? noticeId;

  const NoticeWriteScreen({super.key, this.noticeId});

  @override
  ConsumerState<NoticeWriteScreen> createState() => _NoticeWriteScreenState();
}

class _NoticeWriteScreenState extends ConsumerState<NoticeWriteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isImportant = false;
  bool _isSubmitting = false;
  bool _loaded = false;

  bool get _isEdit => widget.noticeId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final academy = ref.read(currentAcademyProvider).academy;
    if (academy == null) return;

    setState(() => _isSubmitting = true);
    try {
      final repo = ref.read(noticeRepositoryProvider);
      if (_isEdit) {
        await repo.updateNotice(
          academy.id,
          widget.noticeId!,
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          isImportant: _isImportant,
        );
      } else {
        await repo.createNotice(
          academy.id,
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          isImportant: _isImportant,
        );
      }

      ref.invalidate(noticeListProvider);
      if (_isEdit) ref.invalidate(noticeDetailProvider(widget.noticeId!));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEdit ? '공지를 수정했습니다' : '공지를 등록했습니다')),
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                prefixIcon: Icon(Icons.title),
              ),
              maxLength: 200,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? '제목을 입력해주세요' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '내용',
                alignLabelWithHint: true,
              ),
              minLines: 8,
              maxLines: 16,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? '내용을 입력해주세요' : null,
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('중요 공지로 지정'),
              subtitle: const Text('목록 상단에 우선 표시됩니다'),
              value: _isImportant,
              onChanged: (v) => setState(() => _isImportant = v),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _onSubmit,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEdit ? '수정하기' : '등록하기'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = _isEdit ? '공지 수정' : '공지 작성';

    if (!_isEdit) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: _buildForm(),
      );
    }

    final detailAsync = ref.watch(noticeDetailProvider(widget.noticeId!));
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(message: e.toString()),
        data: (notice) {
          if (!_loaded) {
            _titleController.text = notice.title;
            _contentController.text = notice.content;
            _isImportant = notice.isImportant;
            _loaded = true;
          }
          return _buildForm();
        },
      ),
    );
  }
}
