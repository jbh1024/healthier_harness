import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/notice_repository.dart';
import '../../domain/models/notice.dart';

final noticeListProvider = FutureProvider.autoDispose<List<Notice>>((ref) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) return [];
  return ref.read(noticeRepositoryProvider).getNotices(academy.id);
});

final noticeDetailProvider =
    FutureProvider.autoDispose.family<NoticeDetail, int>((ref, noticeId) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) throw Exception('학원이 선택되지 않았습니다');
  return ref.read(noticeRepositoryProvider).getNoticeDetail(academy.id, noticeId);
});
