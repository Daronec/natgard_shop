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

  UnionStateNotifier<ProfileState?> get profileState;

  TextEditingController get phoneTextController;

  TextEditingController get emailTextController;

  TextEditingController get nameTextController;

  TextEditingController get surnameTextController;

  TextEditingController get patronymicTextController;

  TextEditingController get addressTextController;

  TextEditingController get birthdayTextController;

  void changeProfileState();

  void editAvatar();

  void editUser();
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
  void changeProfileState() {
    model.changeProfileState();
  }

  @override
  void editAvatar() async {
    await getImage().then((image) {
      if (image != null) {
        model.editAvatar(image);
      }
    });
  }

  @override
  TextEditingController get addressTextController => model.addressTextController;

  @override
  TextEditingController get birthdayTextController => model.birthdayTextController;

  @override
  TextEditingController get emailTextController => model.emailTextController;

  @override
  TextEditingController get nameTextController => model.nameTextController;

  @override
  TextEditingController get patronymicTextController => model.patronymicTextController;

  @override
  TextEditingController get phoneTextController => model.phoneTextController;

  @override
  TextEditingController get surnameTextController => model.surnameTextController;

  @override
  UnionStateNotifier<ProfileState?> get profileState => model.profileState;

  @override
  void editUser() {
    model.editUser();
  }
}
