import 'dart:async';

import 'package:client_mobile/source/routes.dart';
import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:client_mobile/ui/audio/di/audio_scope.dart';
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

  UnionStateNotifier<bool> get state;

  UnionStateNotifier<AuthState> get authState;

  TextEditingController get phoneTextController;

  TextEditingController get emailTextController;

  TextEditingController get passwordTextController;

  TextEditingController get confirmPasswordTextController;

  TextEditingController get nameTextController;

  TextEditingController get codeTextController;

  GlobalKey<FormState> get emailFormKey;

  GlobalKey<FormState> get passwordFormKey;

  GlobalKey<FormState> get confirmPasswordFormKey;

  GlobalKey<FormState> get nameFormKey;

  GlobalKey<FormState> get codeFormKey;

  Future<void> login();

  Future<void> registration();

  Future<void> confirmCode();

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
  TextEditingController get confirmPasswordTextController => model.confirmPasswordTextController;

  @override
  TextEditingController get phoneTextController => model.phoneTextController;

  @override
  UnionStateNotifier<bool> get state => model.state;

  @override
  UnionStateNotifier<UserModel?> get user => model.user;

  @override
  UnionStateNotifier<AuthState> get authState => model.authState;

  @override
  Future<void> login() async {
    await model.login();
  }

  @override
  Future<void> registration() async {
    await model.registration();
  }

  @override
  Future<void> confirmCode() async {
    model.confirmCode();
  }

  @override
  GlobalKey<FormState> get confirmPasswordFormKey => model.confirmPasswordFormKey;

  @override
  GlobalKey<FormState> get emailFormKey => model.emailFormKey;

  @override
  GlobalKey<FormState> get passwordFormKey => model.passwordFormKey;

  @override
  GlobalKey<FormState> get nameFormKey => model.nameFormKey;

  @override
  TextEditingController get nameTextController => model.nameTextController;

  @override
  GlobalKey<FormState> get codeFormKey => model.codeFormKey;

  @override
  TextEditingController get codeTextController => model.codeTextController;

  @override
  void goToHome() {
    context.pushNamed(Pages.catalog);
  }
}
