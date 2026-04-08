import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../providers/admin_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('대시보드')),
      body: dashboardAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(dashboardProvider),
        ),
        data: (dashboard) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 요약 카드
                Row(
                  children: [
                    Expanded(child: _StatCard(
                      label: '총 멤버',
                      value: '${dashboard.totalMembers}',
                      icon: Icons.people,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(
                      label: '수업 수',
                      value: '${dashboard.totalCourses}',
                      icon: Icons.class_,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(
                      label: '활성 수강',
                      value: '${dashboard.activeEnrollments}',
                      icon: Icons.how_to_reg,
                    )),
                  ],
                ),
                const SizedBox(height: 24),

                // 강사별 현황
                Text('강사별 수강생 현황', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (dashboard.instructorStats.isEmpty)
                  const Text('강사 데이터 없음')
                else
                  ...dashboard.instructorStats.map((stat) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(stat.instructorName),
                      subtitle: Text('수업 ${stat.courseCount}개 | 수강생 ${stat.totalEnrollments}명'),
                    ),
                  )),
                const SizedBox(height: 24),

                // 수강생별 현황
                Text('수강생별 수업 현황', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (dashboard.studentStats.isEmpty)
                  const Text('수강생 데이터 없음')
                else
                  ...dashboard.studentStats.map((stat) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.school)),
                      title: Text(stat.studentName),
                      subtitle: Text('수강 중 ${stat.enrolledCourses}개'),
                    ),
                  )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            )),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
