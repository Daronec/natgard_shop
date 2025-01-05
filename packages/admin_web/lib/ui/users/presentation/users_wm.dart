import 'dart:async';

import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:admin_web/ui/audio/di/audio_scope.dart';
import 'package:elementary/elementary.dart';
import 'package:provider/provider.dart';
import 'package:shared/imports.dart';
import 'package:union_state/union_state.dart';

import 'users_model.dart';
import 'users_screen.dart';

/// DI factory for [UsersWM].
UsersWM defaultUsersWMFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();

  return UsersWM(
    UsersModel(
      logWriter: appScope.logger,
    ),
  );
}

abstract interface class IUsersWM implements IWidgetModel {
  UnionStateNotifier<List<UserModel>> get users;

  UnionStateNotifier<bool> get result;

  Future<void> getUsers(String channelId) async {}
}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class UsersWM extends WidgetModel<UsersScreen, UsersModel> implements IUsersWM {
  @override
  UnionStateNotifier<List<UserModel>> get users => model.users;

  @override
  UnionStateNotifier<bool> get result => model.result;

  /// {@macro feature_example_wm.class}
  UsersWM(super._model);

  @override
  void initWidgetModel() {
    unawaited(model.getUsers());
    super.initWidgetModel();
  }

  @override
  Future<void> getUsers(String channelId) async {
    unawaited(model.getUsers());
  }
}
