import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.read(dioProvider));
});

class NotificationRepository {
  final Dio _dio;

  NotificationRepository(this._dio);

  Future<List<AppNotification>> getNotifications({int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/notifications',
        queryParameters: {'page': page, 'size': size},
      );
      final content = response.data['data']['content'] as List<dynamic>;
      return content.map((e) => AppNotification.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _dio.get('/notifications/unread-count');
      return response.data['data']['count'] as int;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await _dio.put('/notifications/$id/read');
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _dio.put('/notifications/read-all');
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<NotificationSettings> getSettings() async {
    try {
      final response = await _dio.get('/notification-settings');
      return NotificationSettings.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<NotificationSettings> updateSettings({
    bool? enrollmentNotify,
    bool? noticeNotify,
    bool? commentNotify,
  }) async {
    try {
      final response = await _dio.put(
        '/notification-settings',
        data: {
          if (enrollmentNotify != null) 'enrollmentNotify': enrollmentNotify,
          if (noticeNotify != null) 'noticeNotify': noticeNotify,
          if (commentNotify != null) 'commentNotify': commentNotify,
        },
      );
      return NotificationSettings.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
