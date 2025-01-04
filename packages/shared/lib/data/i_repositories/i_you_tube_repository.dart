import 'package:shared/imports.dart';

abstract interface class IYouTubeRepository {
  RequestOperation<List<VideoModel>> getVideosChannel({
    required String channelId,
  });
}
