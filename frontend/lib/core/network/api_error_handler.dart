import 'package:dio/dio.dart';

class AppException implements Exception {
  final String code;
  final String message;
  final int? statusCode;

  const AppException({
    required this.code,
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'AppException($code): $message';
}

class ApiErrorHandler {
  static AppException handle(DioException error) {
    if (error.response?.data is Map<String, dynamic>) {
      final data = error.response!.data as Map<String, dynamic>;
      final errorDetail = data['error'] as Map<String, dynamic>?;
      if (errorDetail != null) {
        return AppException(
          code: errorDetail['code'] as String? ?? 'UNKNOWN',
          message: errorDetail['message'] as String? ?? '알 수 없는 오류가 발생했습니다',
          statusCode: error.response?.statusCode,
        );
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(
          code: 'TIMEOUT',
          message: '서버 응답 시간이 초과되었습니다',
        );
      case DioExceptionType.connectionError:
        return const AppException(
          code: 'CONNECTION_ERROR',
          message: '서버에 연결할 수 없습니다',
        );
      default:
        return AppException(
          code: 'UNKNOWN',
          message: error.message ?? '알 수 없는 오류가 발생했습니다',
          statusCode: error.response?.statusCode,
        );
    }
  }
}
