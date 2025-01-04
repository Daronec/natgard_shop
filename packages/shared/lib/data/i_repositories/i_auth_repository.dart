import 'package:rxdart/rxdart.dart';
import 'package:shared/imports.dart';

abstract interface class IAuthRepository {
  UserModel? currentUser;
  final currentUserStream = BehaviorSubject<UserModel?>.seeded(null);

  Future<bool> login({
    required String email,
    required String password,
    String? code,
  });

  Future<bool> register({
    required UserModel user,
  });

  Future<UserModel?> getCurrentUser();


  Future<bool> updateToken({
    required String refreshToken,
  });

  Future<bool> logout();

  Future<UserModel?> editUser(UserModel user);

  Future<bool> deleteUser(int userId);

}

