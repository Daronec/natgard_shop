import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';

/// {@template feature_example_model.class}
/// [ElementaryModel] for [FeatureExampleScreen].
/// {@endtemplate}
final class YouTubeModel extends BaseModel {
  final IYouTubeRepository _repository;
  final _state = UnionStateNotifier<List<VideoModel>>.new([]);

  /// State of screen.
  UnionStateNotifier<List<VideoModel>> get state => _state;

  /// {@macro feature_example_model.class}
  YouTubeModel({
    required IYouTubeRepository repository,
    required super.logWriter,
  }) : _repository = repository;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  Future<void> getVideosChannel(String channelId) async {
    _state.loading();
    final result = await _repository.getVideosChannel(
      channelId: channelId,
    );
    switch (result) {
      case ResultOk(:final data):
        _state.content(data);
      case ResultFailed(:final failure):
        _state.failure(failure);
    }
  }
}
