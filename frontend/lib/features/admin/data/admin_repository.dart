import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/dashboard.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(ref.read(dioProvider));
});

class AdminRepository {
  final Dio _dio;

  AdminRepository(this._dio);

  Future<Dashboard> getDashboard(int academyId) async {
    try {
      final response = await _dio.get('/academies/$academyId/dashboard');
      return Dashboard.fromJson(response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
