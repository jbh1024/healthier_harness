import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorageService _storage;
  bool _isRefreshing = false;

  TokenRefreshInterceptor(this._dio, this._storage);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || _isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) {
        await _storage.deleteTokens();
        return handler.next(err);
      }

      final response = await _dio.post(
        ApiConstants.refresh,
        data: {'refreshToken': refreshToken},
      );

      final data = response.data['data'] as Map<String, dynamic>;
      final newAccessToken = data['accessToken'] as String;
      final newRefreshToken = data['refreshToken'] as String;

      await _storage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      // 원래 요청 재시도
      final requestOptions = err.requestOptions;
      requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await _dio.fetch(requestOptions);
      return handler.resolve(retryResponse);
    } catch (e) {
      await _storage.deleteTokens();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
