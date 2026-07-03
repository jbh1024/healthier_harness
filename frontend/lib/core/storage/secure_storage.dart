import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    // 웹(flutter_secure_storage_web)은 최초 쓰기 시 암호화 키를 생성하므로
    // 동시 쓰기 시 키 생성 레이스로 토큰 복호화가 깨짐(OperationError) → 순차 쓰기 필수
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return _readOrRecover(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _readOrRecover(_refreshTokenKey);
  }

  /// 복호화 실패(저장소 손상) 시 토큰을 정리하고 미로그인 상태로 복구
  Future<String?> _readOrRecover(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (_) {
      await deleteTokens();
      return null;
    }
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<bool> hasTokens() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
