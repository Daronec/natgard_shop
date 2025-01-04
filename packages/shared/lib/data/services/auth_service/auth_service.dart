import 'package:retrofit/retrofit.dart';
import 'package:shared/imports.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(Endpoints.auth)
  Future<AuthTokenPair?> login({
    @Part() required String email,
    @Part() required String password,
    @Part() String? code,
  });

  @POST(Endpoints.auth)
  @Header(r'$Content-Type: application/json')
  Future<bool> checkUser({
    @Field('serviceId') required String serviceId,
    @Field('servicePlatform') required String servicePlatform,
  });

  @POST(Endpoints.auth)
  @Header(r'$Content-Type: application/json')
  Future<AuthTokenPair?> register({
    @Body() required UserModel user,
  });

  @GET(Endpoints.auth)
  Future<UserModel?> getCurrentUser();

  @PUT(Endpoints.auth)
  Future<UserModel?> editUser(@Body() UserModel user);

  @DELETE('${Endpoints.auth}/{userId}')
  Future<bool> deleteUser(@Path('userId') int userId);

  @POST("/auth/refresh")
  Future<AuthTokenPair?> updateToken({
    @Query('refreshToken') required String refreshToken,
  });

  @DELETE("auth/logout")
  Future<bool> logout();
}
