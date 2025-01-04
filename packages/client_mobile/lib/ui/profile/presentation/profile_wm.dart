import 'dart:async';

import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:client_mobile/ui/audio/di/audio_scope.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'package:union_state/union_state.dart';

import 'profile_model.dart';
import 'profile_screen.dart';

/// DI factory for [ProfileWM].
ProfileWM defaultAudioWMFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();

  return ProfileWM(
    ProfileModel(
      logWriter: appScope.logger,
    ),
  );
}

/// Interface for [ProfileWM].
abstract interface class IProfileWM implements IWidgetModel {
  UnionStateNotifier<UserModel?> get user;

  void changeProfileState(ProfileState state);

  void editAvatar();
}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class ProfileWM extends WidgetModel<ProfileScreen, ProfileModel> implements IProfileWM {
  /// {@macro feature_example_wm.class}
  ProfileWM(super._model);

  @override
  void initWidgetModel() async {
    await model.getCurrentUser();
    super.initWidgetModel();
  }

  @override
  UnionStateNotifier<UserModel?> get user => model.user;

  @override
  void changeProfileState(ProfileState state) {
    model.changeProfileState(state);
  }

  @override
  void editAvatar() async {
    await getImage().then((image) {
      if (image != null) {
        model.editAvatar(image);
      }
    });
  }
}
