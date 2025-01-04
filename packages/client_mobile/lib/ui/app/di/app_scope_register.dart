import 'dart:io';

import 'package:client_mobile/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared/common/utils/logger/log_writer.dart';
import 'package:shared/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_scope.dart';
import 'package:surf_logger/surf_logger.dart' as surf_logger;

/// {@template app_scope_register.class}
/// Creates and initializes AppScope.
/// {@endtemplate}
final class AppScopeRegister {
  /// {@macro app_scope_register.class}
  const AppScopeRegister();

  /// Create scope.
  Future<IAppScope> createScope() async {
    HttpOverrides.global = MyHttpOverrides();
    await preRunFunction();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider:  kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.appAttest,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    final appConfig = _createAppConfig(sharedPreferences);
    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
        );
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
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = '${packageInfo.version}+${packageInfo.buildNumber}';
    final surfLogger = surf_logger.Logger.withStrategies({});
    final logger = LogWriter(surfLogger);
    return AppScope(
      versionApp: '1',
      logger: logger,
      appConfig: appConfig,
      sharedPreferences: sharedPreferences,
      dio: dio,
      tokenStorage: storage,
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
