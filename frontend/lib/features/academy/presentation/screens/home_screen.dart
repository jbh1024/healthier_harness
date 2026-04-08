import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/academy_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final academyState = ref.watch(currentAcademyProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(academyState.academy?.name ?? 'Healthier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: '학원 전환',
            onPressed: () {
              ref.read(currentAcademyProvider.notifier).clear();
              context.go('/academy-select');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              ref.read(currentAcademyProvider.notifier).clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          child: Text(
                            user?.name.isNotEmpty == true
                                ? user!.name[0]
                                : '?',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? '',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                _roleLabel(academyState.role ?? ''),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (academyState.role == 'STUDENT') ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.confirmation_number_outlined),
                          const SizedBox(width: 8),
                          Text(
                            '잔여 수강 횟수: ${academyState.remainingCredits ?? 0}회',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '빠른 메뉴',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _QuickMenuCard(
                  icon: Icons.class_outlined,
                  label: '수업',
                  onTap: () => context.push('/courses'),
                ),
                _QuickMenuCard(
                  icon: Icons.how_to_reg_outlined,
                  label: '내 수강',
                  onTap: () => context.push('/enrollments/me'),
                ),
                _QuickMenuCard(
                  icon: Icons.forum_outlined,
                  label: '게시판',
                  onTap: () => context.push('/board'),
                ),
                _QuickMenuCard(
                  icon: Icons.campaign_outlined,
                  label: '공지',
                  onTap: () => context.push('/notices')
                ),
              ],
            ),
          ],
        ),
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

class _QuickMenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickMenuCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Icon(icon, size: 32),
                const SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
