import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_error_handler.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../../enrollment/data/enrollment_repository.dart';
import '../providers/course_provider.dart';

class CourseDetailScreen extends ConsumerWidget {
  final int courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseDetailProvider(courseId));
    final academyState = ref.watch(currentAcademyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('수업 상세')),
      body: courseAsync.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(message: e.toString()),
        data: (course) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  '강사: ${course.instructorName}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 16),
                if (course.description != null) ...[
                  Text(course.description!),
                  const SizedBox(height: 16),
                ],
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InfoRow(
                          label: '정원',
                          value:
                              '${course.currentEnrollment}/${course.maxCapacity}명',
                        ),
                        const Divider(),
                        _InfoRow(
                          label: '수강신청 방식',
                          value: course.enrollmentType == 'AUTO_APPROVE'
                              ? '자동 승인'
                              : '수동 승인 (관리자 확인 필요)',
                        ),
                        const Divider(),
                        _InfoRow(
                          label: '상태',
                          value: _statusLabel(course.status),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (academyState.role == 'STUDENT' &&
                    course.status == 'OPEN') ...[
                  ElevatedButton.icon(
                    onPressed: () => _enroll(context, ref),
                    icon: const Icon(Icons.how_to_reg),
                    label: Text(
                      course.isFull ? '대기열 등록' : '수강 신청',
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _enroll(BuildContext context, WidgetRef ref) async {
    final academy = ref.read(currentAcademyProvider).academy;
    if (academy == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('수강 신청'),
        content: const Text('수강 신청하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('신청'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final enrollment = await ref
          .read(enrollmentRepositoryProvider)
          .enroll(academy.id, courseId);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('수강 신청 완료: ${enrollment.statusLabel}')),
      );
      ref.invalidate(courseDetailProvider(courseId));
    } on AppException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'OPEN':
        return '모집 중';
      case 'IN_PROGRESS':
        return '진행 중';
      case 'COMPLETED':
        return '완료';
      case 'CLOSED':
        return '마감';
      default:
        return status;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
