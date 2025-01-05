import 'dart:async';

import 'package:admin_web/source/routes.dart';
import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'package:union_state/union_state.dart';

import 'auth_model.dart';
import 'auth_screen.dart';

/// DI factory for [AuthWM].
AuthWM defaultAudioWMFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();

  return AuthWM(
    AuthModel(
      scope: appScope,
      logWriter: appScope.logger,
    ),
  );
}

/// Interface for [AuthWM].
abstract interface class IAuthWM implements IWidgetModel {
  UnionStateNotifier<UserModel?> get user;

  UnionStateNotifier<AuthState> get authState;

  TextEditingController get emailTextController;

  TextEditingController get passwordTextController;

  GlobalKey<FormState> get emailFormKey;

  GlobalKey<FormState> get passwordFormKey;

  Future<void> login();

  void goToHome();
}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class AuthWM extends WidgetModel<AuthScreen, AuthModel> implements IAuthWM {
  /// {@macro feature_example_wm.class}
  AuthWM(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  TextEditingController get emailTextController => model.emailTextController;

  @override
  TextEditingController get passwordTextController => model.passwordTextController;

  @override
  UnionStateNotifier<UserModel?> get user => model.user;

  @override
  UnionStateNotifier<AuthState> get authState => model.authState;

  @override
  Future<void> login() async {
    await model.login();
  }

  @override
  GlobalKey<FormState> get emailFormKey => model.emailFormKey;

  @override
  GlobalKey<FormState> get passwordFormKey => model.passwordFormKey;

  @override
  void goToHome() {
    context.pushNamed(Pages.audio.value);
  }
}
