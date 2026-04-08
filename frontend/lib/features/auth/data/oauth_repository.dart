import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_error_handler.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage.dart';
import '../domain/models/token_pair.dart';

final oauthRepositoryProvider = Provider<OAuthRepository>((ref) {
  return OAuthRepository(ref.read(dioProvider), ref.read(secureStorageProvider));
});

class OAuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;

  OAuthRepository(this._dio, this._storage);

  Future<void> loginWithGoogle(String idToken) async {
    try {
      final response = await _dio.post('/auth/google', data: {'idToken': idToken});
      final tokenPair = TokenPair.fromJson(response.data['data'] as Map<String, dynamic>);
      await _storage.saveTokens(accessToken: tokenPair.accessToken, refreshToken: tokenPair.refreshToken);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> linkGoogle(String idToken) async {
    try {
      await _dio.post('/auth/google/link', data: {'idToken': idToken});
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> unlinkGoogle() async {
    try {
      await _dio.delete('/auth/google/link');
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> registerPasskey({
    required String credentialId,
    required String publicKey,
    String? deviceName,
  }) async {
    try {
      await _dio.post('/auth/passkey/register', data: {
        'credentialId': credentialId,
        'publicKey': publicKey,
        if (deviceName != null) 'deviceName': deviceName,
      });
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> authenticatePasskey({
    required String credentialId,
    int signCount = 0,
  }) async {
    try {
      final response = await _dio.post('/auth/passkey/authenticate', data: {
        'credentialId': credentialId,
        'signCount': signCount,
      });
      final tokenPair = TokenPair.fromJson(response.data['data'] as Map<String, dynamic>);
      await _storage.saveTokens(accessToken: tokenPair.accessToken, refreshToken: tokenPair.refreshToken);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<void> deletePasskey(int passkeyId) async {
    try {
      await _dio.delete('/auth/passkey/$passkeyId');
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
