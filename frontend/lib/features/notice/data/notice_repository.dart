import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/notice.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  return NoticeRepository(ref.read(dioProvider));
});

class NoticeRepository {
  final Dio _dio;

  NoticeRepository(this._dio);

  Future<List<Notice>> getNotices(int academyId, {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        ApiConstants.notices(academyId),
        queryParameters: {'page': page, 'size': size},
      );
      final content = response.data['data']['content'] as List<dynamic>;
      return content.map((e) => Notice.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<NoticeDetail> getNoticeDetail(int academyId, int noticeId) async {
    try {
      final response = await _dio.get(ApiConstants.noticeDetail(academyId, noticeId));
      return NoticeDetail.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> createNotice(
    int academyId, {
    required String title,
    required String content,
    required bool isImportant,
  }) async {
    try {
      await _dio.post(
        ApiConstants.notices(academyId),
        data: {
          'title': title,
          'content': content,
          'isImportant': isImportant,
        },
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> updateNotice(
    int academyId,
    int noticeId, {
    required String title,
    required String content,
    required bool isImportant,
  }) async {
    try {
      await _dio.put(
        ApiConstants.noticeDetail(academyId, noticeId),
        data: {
          'title': title,
          'content': content,
          'isImportant': isImportant,
        },
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> deleteNotice(int academyId, int noticeId) async {
    try {
      await _dio.delete(ApiConstants.noticeDetail(academyId, noticeId));
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
