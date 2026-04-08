import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';
import 'auth_interceptor.dart';
import 'token_refresh_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(storage),
    TokenRefreshInterceptor(dio, storage),
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => print(o), // ignore: avoid_print
    ),
  ]);

  return dio;
});
