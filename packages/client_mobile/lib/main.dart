import 'dart:io';

import 'package:client_mobile/ui/app/app_flow.dart';
import 'package:client_mobile/ui/app/di/app_scope_register.dart';
import 'package:shared/imports.dart';

void main() async {

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

