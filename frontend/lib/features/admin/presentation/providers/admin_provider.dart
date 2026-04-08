import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/admin_repository.dart';
import '../../domain/models/dashboard.dart';

final dashboardProvider = FutureProvider.autoDispose<Dashboard>((ref) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) throw Exception('학원이 선택되지 않았습니다');
  return ref.read(adminRepositoryProvider).getDashboard(academy.id);
});
