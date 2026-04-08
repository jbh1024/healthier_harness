import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../providers/enrollment_provider.dart';

class MyEnrollmentsScreen extends ConsumerWidget {
  const MyEnrollmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentsAsync = ref.watch(myEnrollmentsProvider);
    final academyState = ref.watch(currentAcademyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('내 수강 목록')),
      body: Column(
        children: [
          // 잔여 횟수 카드
          if (academyState.role == 'STUDENT')
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '잔여 수강 횟수: ${academyState.remainingCredits ?? 0}회',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          // 수강 목록
          Expanded(
            child: enrollmentsAsync.when(
              loading: () => const LoadingIndicator(),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(myEnrollmentsProvider),
              ),
              data: (enrollments) {
                if (enrollments.isEmpty) {
                  return const EmptyState(
                    message: '수강 신청 내역이 없습니다',
                    icon: Icons.school_outlined,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: enrollments.length,
                  itemBuilder: (context, index) {
                    final enrollment = enrollments[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(enrollment.courseTitle),
                        subtitle: Text(enrollment.statusLabel),
                        trailing: _statusIcon(enrollment.status),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(String status) {
    final (icon, color) = switch (status) {
      'APPROVED' => (Icons.check_circle, Colors.green),
      'PENDING' => (Icons.hourglass_empty, Colors.orange),
      'REJECTED' => (Icons.cancel, Colors.red),
      'CANCELLED' => (Icons.remove_circle_outline, Colors.grey),
      'WAITLISTED' => (Icons.queue, Colors.blue),
      _ => (Icons.help_outline, Colors.grey),
    };
    return Icon(icon, color: color);
  }
}
