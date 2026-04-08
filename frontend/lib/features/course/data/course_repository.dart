import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/course.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository(ref.read(dioProvider));
});

class CourseRepository {
  final Dio _dio;

  CourseRepository(this._dio);

  Future<List<Course>> getCourses(
    int academyId, {
    String? status,
    String? keyword,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.courses(academyId),
        queryParameters: {
          'page': page,
          'size': size,
          if (status != null) 'status': status,
          if (keyword != null) 'keyword': keyword,
        },
      );
      final content = response.data['data']['content'] as List<dynamic>;
      return content
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Course> getCourseDetail(int academyId, int courseId) async {
    try {
      final response = await _dio.get(
        ApiConstants.courseDetail(academyId, courseId),
      );
      return Course.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
