import 'dart:async';

import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:admin_web/ui/youtube/di/youtube_scope.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared/data/models/video_model/video_model.dart';
import 'package:union_state/union_state.dart';

import 'youtube_model.dart';
import 'youtube_screen.dart';

/// DI factory for [YouTubeWM].
YouTubeWM defaultYouTubeWMFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final scope = context.read<IYouTubeScope>();

  return YouTubeWM(
    YouTubeModel(
      repository: scope.repository,
      logWriter: appScope.logger,
    ),
  );
}

/// Interface for [YouTubeWM].
abstract interface class IYouTubeWM implements IWidgetModel {
  /// State of screen.
  UnionStateNotifier<List<VideoModel>> get state;

  late TextEditingController searchTextController = TextEditingController();

  Future<void> getVideos(String channelId) async {}
}

/// {@template feature_example_wm.class}
/// [WidgetModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class YouTubeWM extends WidgetModel<YouTubeScreen, YouTubeModel>
    implements IYouTubeWM {
  @override
  UnionStateNotifier<List<VideoModel>> get state => model.state;

  /// {@macro feature_example_wm.class}
  YouTubeWM(super._model);

  @override
  void initWidgetModel() {
    searchTextController = TextEditingController(
      text: '@frolovchannel',
    );
    unawaited(model.getVideosChannel('@frolovchannel'));
    // unawaited(model.getVideosChannel(channelId));
    super.initWidgetModel();
  }

  @override
  Future<void> getVideos(String channelId) async {
    unawaited(model.getVideosChannel(channelId));
    // await model.getVideosChannel(channelId);
  }

  @override
  late TextEditingController searchTextController;
}
