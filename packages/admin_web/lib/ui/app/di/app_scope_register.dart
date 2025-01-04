import 'package:admin_web/firebase_options.dart';
import 'package:shared/imports.dart';
import 'app_scope.dart';
import 'package:shared/common/utils/logger/log_writer.dart';
import 'package:surf_logger/surf_logger.dart' as surf_logger;

/// {@template app_scope_register.class}
/// Creates and initializes AppScope.
/// {@endtemplate}
final class AppScopeRegister {
  /// {@macro app_scope_register.class}
  const AppScopeRegister();

  /// Create scope.
  Future<IAppScope> createScope() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    final appConfig = _createAppConfig(sharedPreferences);

    const dioConfigurator = DioClient();
    const storage = TokenStorageImpl(
      FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    );

    final dio = await dioConfigurator.create(
      interceptors: [],
      tokenStorage: storage,
      url: appConfig.url,
    );

    dio.interceptors.addAll(
      await AppInterceptors().getInterceptors(
        dio: dio,
        storage: storage,
      ),
    );
    final surfLogger = surf_logger.Logger.withStrategies({});
    final logger = LogWriter(surfLogger);
    return AppScope(
      versionApp: '1',
      appConfig: appConfig,
      sharedPreferences: sharedPreferences,
      dio: dio,
      tokenStorage: storage,
      logger: logger,
      youtubeRepository: YouTubeRepository(
        service: YouTubeService(
          dio,
          baseUrl: baseUrl,
        ),
      ),
      authRepository: AuthRepository(
        tokenStorage: storage,
        service: AuthService(
          dio,
          baseUrl: baseUrl,
        ),
      ),
    );
  }

  AppConfig _createAppConfig(SharedPreferences prefs) {
    return const AppConfig(
      url: baseUrl,
    );
  }
}
