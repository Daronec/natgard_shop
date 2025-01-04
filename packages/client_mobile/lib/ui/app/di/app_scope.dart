import 'package:shared/common/utils/logger/i_log_writer.dart';
import 'package:shared/imports.dart';

/// {@template app_scope.class}
/// Scope of dependencies which are needed through the whole app's life.
/// {@endtemplate}
final class AppScope implements IAppScope {
  @override
  final AppConfig appConfig;
  @override
  final SharedPreferences sharedPreferences;
  @override
  final Dio dio;
  @override
  final TokenStorageImpl tokenStorage;
  @override
  final IAuthRepository authRepository;
  @override
  final String versionApp;
  @override
  final ILogWriter logger;

  /// {@macro app_scope.class}
  const AppScope({
    required this.appConfig,
    required this.sharedPreferences,
    required this.dio,
    required this.tokenStorage,
    required this.authRepository,
    required this.versionApp,
    required this.logger,
  });
}

/// {@macro app_scope.class}
abstract interface class IAppScope {
  /// App configuration.
  AppConfig get appConfig;

  /// Http client.
  Dio get dio;

  /// Shared preferences.
  SharedPreferences get sharedPreferences;

  /// FlutterSecureStorage
  TokenStorageImpl get tokenStorage;

  IAuthRepository get authRepository;

  String get versionApp;

  /// Logger.
  ILogWriter get logger;
}
