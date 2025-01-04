import 'dart:io';

import 'package:admin_web/ui/app/app_flow.dart';
import 'package:admin_web/ui/app/di/app_scope_register.dart';
import 'package:shared/imports.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await preRunFunction();
  await _runApp();
}

Future<void> _runApp() async {
  const scopeRegister = AppScopeRegister();
  final scope = await scopeRegister.createScope();

  runApp(
    RestartWidget(
      child: AppFlow(appScope: scope),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
