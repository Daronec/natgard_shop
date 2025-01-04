import 'package:shared/imports.dart';

class AppInterceptors {
  late Interceptors interceptors;

  Future<Interceptors> getInterceptors({
    required Dio dio,
    required TokenStorageImpl storage,
  }) async {
    interceptors = Interceptors();
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final tokens = await storage.read();
          if (tokens != null && tokens.accessToken != '') {
            request.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
          }
          return handler.next(request);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            if (!e.requestOptions.path.contains('refreshToken')) {
              try {
                await _refreshRequest(dio, storage).then((value) async {
                  e.requestOptions.headers["Authorization"] =
                      "Bearer ${value.accessToken}";
                  final opts = Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                  );
                  final cloneReq = await dio.request(e.requestOptions.path,
                      options: opts,
                      data: e.requestOptions.data,
                      queryParameters: e.requestOptions.queryParameters);

                  return handler.resolve(cloneReq);
                });
              } catch (e, st) {
                debugPrint(e.toString());
              }
            } else {
              await Preferences.clear().then((_) async {
                await storage.delete();
                throw RefreshTokenException(e.requestOptions);
              });
            }
          }
          if (e.response?.statusCode == 404 &&
              e.requestOptions.path.contains('refreshToken')) {
            await storage.delete();
          }
        },
      ),
    );

    return interceptors;
  }

  Future<AuthTokenPair> _refreshRequest(
    Dio dio,
    TokenStorageImpl tokenStorage,
  ) async {
    // await dio
    //     .post(
    //   '${Endpoints.refreshToken}/${Preferences.loadRefreshToken()}',
    //   options: Options(
    //     headers: {},
    //   ),
    // )
    //     .then((value) async {
    //   await tokenStorage.write(
    //     AuthTokenPair(
    //       accessToken: value.data[Keys.accessToken],
    //       refreshToken: value.data[Keys.refreshToken],
    //     ),
    //   );
    //   return AuthTokenPair(
    //     accessToken: value.data[Keys.accessToken],
    //     refreshToken: value.data[Keys.refreshToken],
    //   );
    // });

    return const AuthTokenPair(
      accessToken: '',
    );
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Неверный запрос';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Произошла неизвестная ошибка, повторите попытку позже.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Произошел конфликт';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Пользователь не найден';
  }
}

class NotFoundException extends DioException {
  NotFoundException({
    required String message,
    required super.requestOptions,
  });

  @override
  String toString() {
    return message ?? '';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Интернет-соединение не обнаружено, попробуйте еще раз.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Время ожидания соединения истекло, попробуйте еще раз.';
  }
}

class RefreshTokenException extends DioException {
  RefreshTokenException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Сессия истекла!';
  }
}
