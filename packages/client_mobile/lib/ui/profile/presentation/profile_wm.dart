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
  final scope = context.read<IAudioScope>();

  return ProfileWM(
    ProfileModel(
      logWriter: appScope.logger,
    ),
  );
}

/// Interface for [ProfileWM].
abstract interface class IProfileWM implements IWidgetModel {}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class ProfileWM extends WidgetModel<ProfileScreen, ProfileModel> implements IProfileWM {
  /// {@macro feature_example_wm.class}
  ProfileWM(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }
}
