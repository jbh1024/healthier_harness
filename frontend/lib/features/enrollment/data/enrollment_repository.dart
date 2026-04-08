import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/enrollment.dart';

final enrollmentRepositoryProvider = Provider<EnrollmentRepository>((ref) {
  return EnrollmentRepository(ref.read(dioProvider));
});

class EnrollmentRepository {
  final Dio _dio;

  EnrollmentRepository(this._dio);

  Future<Enrollment> enroll(int academyId, int courseId) async {
    try {
      final response = await _dio.post(
        ApiConstants.enrollments(academyId, courseId),
      );
      return Enrollment.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<List<Enrollment>> getMyEnrollments(int academyId) async {
    try {
      final response = await _dio.get(
        '/academies/$academyId/enrollments/me',
      );
      final list = response.data['data'] as List<dynamic>;
      return list
          .map((e) => Enrollment.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
