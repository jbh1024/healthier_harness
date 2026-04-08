import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/course_repository.dart';
import '../../domain/models/course.dart';

final courseListProvider = FutureProvider.autoDispose<List<Course>>((ref) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) return [];
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourses(academy.id);
});

final courseDetailProvider =
    FutureProvider.autoDispose.family<Course, int>((ref, courseId) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) throw Exception('학원이 선택되지 않았습니다');
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourseDetail(academy.id, courseId);
});
