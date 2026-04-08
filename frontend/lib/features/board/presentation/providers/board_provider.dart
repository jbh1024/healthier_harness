import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../academy/presentation/providers/academy_provider.dart';
import '../../data/board_repository.dart';
import '../../domain/models/board_post.dart';

final boardListProvider = FutureProvider.autoDispose<List<BoardPost>>((ref) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) return [];
  return ref.read(boardRepositoryProvider).getPosts(academy.id);
});

final boardDetailProvider =
    FutureProvider.autoDispose.family<BoardPostDetail, int>((ref, postId) async {
  final academy = ref.watch(currentAcademyProvider).academy;
  if (academy == null) throw Exception('학원이 선택되지 않았습니다');
  return ref.read(boardRepositoryProvider).getPostDetail(academy.id, postId);
});
