import 'package:rxdart/subjects.dart';
import 'package:shared/imports.dart';

import '../services/auth_service/auth_service.dart';

final class AuthRepository implements IAuthRepository {
  final AuthService _service;
  final TokenStorageImpl _tokenStorage;
  @override
  UserModel? currentUser;

  @override
  final currentUserStream = BehaviorSubject<UserModel?>.seeded(null);

  AuthRepository({
    required TokenStorageImpl tokenStorage,
    required AuthService service,
  })  : _service = service,
        _tokenStorage = tokenStorage;

  @override
  Future<bool> login({
    required String email,
    required String password,
    String? code,
  }) async {
    final res = await _service.login(
      email: email,
      password: password,
      code: code,
    );
    if (res != null) {
      await _tokenStorage.write(res);
    }

    return res != null;
  }

  @override
  Future<bool> checkUser({
    required String serviceId,
    required String servicePlatform,
  }) async {
    return await _service.checkUser(
      serviceId: serviceId,
      servicePlatform: servicePlatform,
    );
  }

  @override
  Future<bool> register({
    required UserModel user,
  }) async {
    final res = await _service.register(
      user: user,
    );
    if (res != null) {
      await _tokenStorage.write(res);
    }
    return res != null;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final response = await _service.getCurrentUser();
    if (response != null) {
      currentUser = response;
      currentUserStream.add(response);
    }
    return currentUser;
  }

  @override
  Future<bool> updateToken({
    required String refreshToken,
  }) async {
    final res = await _service.updateToken(
      refreshToken: refreshToken,
    );
    if (res != null) {
      await _tokenStorage.write(res);
    }
    return res != null;
  }

  @override
  Future<bool> logout() async {
    bool result = false;
    final tokens = await _tokenStorage.read();
    if (tokens?.accessToken != null) {
      try {
        final response = await _service.logout();
        result = response;
        if (result) {
          Preferences.clear();
          currentUserStream.add(null);
          currentUser = null;
        }
      } catch (ex) {
        debugPrint(ex.toString());
      }
    }
    return result;
  }

  @override
  Future<UserModel?> editUser(UserModel user) async {
    final response = await _service.editUser(user);
    currentUserStream.add(response);
    currentUser = response;
    return response;
  }

  @override
  Future<bool> deleteUser(int userId) async {
    final response = await _service.deleteUser(userId);
    return response;
  }
}
