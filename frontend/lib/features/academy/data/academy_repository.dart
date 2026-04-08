import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../domain/models/academy.dart';

final academyRepositoryProvider = Provider<AcademyRepository>((ref) {
  return AcademyRepository(ref.read(dioProvider));
});

class AcademyRepository {
  final Dio _dio;

  AcademyRepository(this._dio);

  Future<List<Academy>> getMyAcademies() async {
    try {
      final response = await _dio.get(ApiConstants.academies);
      final list = response.data['data'] as List<dynamic>;
      return list
          .map((e) => Academy.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Academy> getAcademyDetail(int academyId) async {
    try {
      final response = await _dio.get(ApiConstants.academyDetail(academyId));
      return Academy.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
