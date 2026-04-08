import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class AcademyJoinScreen extends ConsumerStatefulWidget {
  const AcademyJoinScreen({super.key});

  @override
  ConsumerState<AcademyJoinScreen> createState() => _AcademyJoinScreenState();
}

class _AcademyJoinScreenState extends ConsumerState<AcademyJoinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inviteCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _onJoin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    // TODO: join-academy API 호출 (Phase 2에서 구현)
    // 임시로 사용자 정보 갱신
    await ref.read(authProvider.notifier).refreshUser();

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('학원 가입 기능은 Phase 2에서 구현됩니다')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학원 가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '초대코드를 입력하여\n학원에 가입하세요',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _inviteCodeController,
                decoration: const InputDecoration(
                  labelText: '초대코드',
                  prefixIcon: Icon(Icons.card_giftcard_outlined),
                  hintText: '예: ABC123',
                ),
                textCapitalization: TextCapitalization.characters,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return '초대코드를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _onJoin,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('가입하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
