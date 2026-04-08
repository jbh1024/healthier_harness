import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage.dart';
import '../domain/models/token_pair.dart';
import '../domain/models/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(dioProvider),
    ref.read(secureStorageProvider),
  );
});

class AuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;

  AuthRepository(this._dio, this._storage);

  Future<User> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? inviteCode,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.signup,
        data: {
          'email': email,
          'password': password,
          'name': name,
          if (phone != null) 'phone': phone,
          if (inviteCode != null) 'inviteCode': inviteCode,
        },
      );

      final tokenPair = TokenPair.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
      await _storage.saveTokens(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken,
      );

      return getMe();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final tokenPair = TokenPair.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
      await _storage.saveTokens(
        accessToken: tokenPair.accessToken,
        refreshToken: tokenPair.refreshToken,
      );

      return getMe();
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } catch (_) {
      // 로그아웃 실패해도 로컬 토큰 삭제
    } finally {
      await _storage.deleteTokens();
    }
  }

  Future<User> getMe() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      return User.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<bool> hasValidSession() async {
    return _storage.hasTokens();
  }
}
