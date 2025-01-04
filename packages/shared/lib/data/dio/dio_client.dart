import 'dart:io';

import 'package:dio/io.dart';
import 'package:shared/imports.dart';

class DioClient {
  const DioClient();

  /// Creating a client [Dio].
  Future<Dio> create({
    required Iterable<Interceptor> interceptors,
    required String url,
    required TokenStorageImpl tokenStorage,
  }) async {
    const timeout = Duration(seconds: 30);

    final dio = Dio();
    AuthTokenPair? token = await tokenStorage.read();
    dio.options
      ..baseUrl = url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..contentType = 'application/json'
      ..headers = {
        "Content-Type": "application/json",
        if (token != null && token.accessToken.isNotEmpty)
          "Authorization": 'Bearer ${token.accessToken}',
      }
      ..sendTimeout = timeout;

    if (!kIsWeb) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        return client;
      };
    }

    dio.interceptors.addAll(interceptors);

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
