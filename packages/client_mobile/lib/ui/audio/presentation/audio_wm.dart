import 'dart:async';

import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:client_mobile/ui/audio/di/audio_scope.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'package:union_state/union_state.dart';

import 'audio_model.dart';
import 'audio_screen.dart';

/// DI factory for [AudioWM].
AudioWM defaultAudioWMFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final scope = context.read<IAudioScope>();

  return AudioWM(
    AudioModel(
      logWriter: appScope.logger,
    ),
  );
}

/// Interface for [AudioWM].
abstract interface class IAudioWM implements IWidgetModel {
  /// State of screen.
  UnionStateNotifier<List<AudioDto>> get audio;

  UnionStateNotifier<List<String>> get audioUploaded;

  UnionStateNotifier<bool> get uploadState;

  UnionStateNotifier<bool> get result;

  String? get fileLink;

  Future<void> getAudioData(String channelId) async {}

  Future<void> addAudio(AudioDto value) async {}

  Future<void> editAudio(AudioDto value) async {}

  Future<void> deleteAudio(AudioDto value) async {}
}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class AudioWM extends WidgetModel<AudioScreen, AudioModel> implements IAudioWM {
  @override
  UnionStateNotifier<List<AudioDto>> get audio => model.audio;

  @override
  UnionStateNotifier<bool> get result => model.result;

  @override
  String? get fileLink => model.fileLink;

  @override
  UnionStateNotifier<bool> get uploadState => model.uploadState;

  /// {@macro feature_example_wm.class}
  AudioWM(super._model);

  @override
  void initWidgetModel() {
    unawaited(model.getAudioData());
    super.initWidgetModel();
  }

  @override
  Future<void> getAudioData(String channelId) async {
    unawaited(model.getAudioData());
  }

  @override
  Future<void> addAudio(AudioDto value) async {
    model.addAudio(value);
  }

  @override
  Future<void> deleteAudio(AudioDto value) async {
    model.deleteAudio(value);
  }

  @override
  UnionStateNotifier<List<String>> get audioUploaded => model.audioUploaded;

  @override
  Future<void> editAudio(AudioDto value) async {
    model.editAudio(value);
  }
}
