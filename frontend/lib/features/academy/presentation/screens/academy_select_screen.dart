import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/academy_provider.dart';

class AcademySelectScreen extends ConsumerWidget {
  const AcademySelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('학원 선택'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              ref.read(currentAcademyProvider.notifier).clear();
            },
          ),
        ],
      ),
      body: user == null || user.academies.isEmpty
          ? const EmptyState(
              message: '소속된 학원이 없습니다.\n초대코드로 학원에 가입해주세요.',
              icon: Icons.school_outlined,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: user.academies.length,
              itemBuilder: (context, index) {
                final academy = user.academies[index];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.school),
                    ),
                    title: Text(academy.academyName),
                    subtitle: Text(
                      '${_roleLabel(academy.role)} | 잔여 ${academy.remainingCredits}회',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ref
                          .read(currentAcademyProvider.notifier)
                          .selectFromUserAcademy(academy);
                      context.go('/home');
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/academy-join'),
        icon: const Icon(Icons.add),
        label: const Text('학원 가입'),
      ),
    );
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'ACADEMY_ADMIN':
        return '관리자';
      case 'INSTRUCTOR':
        return '강사';
      case 'STUDENT':
        return '수강생';
      default:
        return role;
    }
  }
}
