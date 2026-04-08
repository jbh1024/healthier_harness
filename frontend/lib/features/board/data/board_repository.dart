import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/board_post.dart';

final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  return BoardRepository(ref.read(dioProvider));
});

class BoardRepository {
  final Dio _dio;

  BoardRepository(this._dio);

  Future<List<BoardPost>> getPosts(int academyId, {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        ApiConstants.board(academyId),
        queryParameters: {'page': page, 'size': size},
      );
      final content = response.data['data']['content'] as List<dynamic>;
      return content.map((e) => BoardPost.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<BoardPostDetail> getPostDetail(int academyId, int postId) async {
    try {
      final response = await _dio.get(ApiConstants.boardDetail(academyId, postId));
      return BoardPostDetail.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<BoardPost> createPost(int academyId, {required String title, required String content}) async {
    try {
      final response = await _dio.post(
        ApiConstants.board(academyId),
        data: {'title': title, 'content': content},
      );
      return BoardPost.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Comment> createComment(int academyId, int postId, {required String content, int? parentId}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.boardDetail(academyId, postId)}/comments',
        data: {'content': content, if (parentId != null) 'parentId': parentId},
      );
      return Comment.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
