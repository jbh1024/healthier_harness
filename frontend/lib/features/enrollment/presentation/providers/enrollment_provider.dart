import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/enrollment_repository.dart';
import '../../domain/models/enrollment.dart';

final myEnrollmentsProvider =
    FutureProvider.autoDispose<List<Enrollment>>((ref) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) return [];
  final repository = ref.read(enrollmentRepositoryProvider);
  return repository.getMyEnrollments(academy.id);
});
