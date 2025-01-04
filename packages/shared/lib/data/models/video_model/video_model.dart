import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_model.freezed.dart';

part 'video_model.g.dart';

@freezed
class VideoModel with _$VideoModel {
  const factory VideoModel({
    String? videoId,
    String? duration,
    String? title,
    String? channelName,
    String? views,
    List<ThumbnailModel>? thumbnails,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  factory VideoModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const VideoModel();

    if (map.containsKey("videoRenderer")) {
      return _fromVideoRenderer(map);
    } else if (map.containsKey("compactVideoRenderer")) {
      return _fromCompactVideoRenderer(map);
    } else if (map.containsKey("gridVideoRenderer")) {
      return _fromGridVideoRenderer(map);
    }
    return const VideoModel();
  }

  static VideoModel _fromVideoRenderer(Map<String, dynamic> map) {
    final videoRenderer = map['videoRenderer'];
    final lengthText = videoRenderer?['lengthText'];
    final simpleText = videoRenderer?['shortViewCountText']?['simpleText'];

    final thumbnails = <ThumbnailModel>[];
    videoRenderer?['thumbnail']['thumbnails']?.forEach((thumbnail) {
      thumbnails.add(ThumbnailModel(
        url: thumbnail['url'],
        width: thumbnail['width'],
        height: thumbnail['height'],
      ));
    });

    return VideoModel(
      videoId: videoRenderer?['videoId'],
      duration: lengthText == null ? "Live" : lengthText?['simpleText'],
      title: videoRenderer?['title']?['runs']?[0]?['text'],
      channelName: videoRenderer?['longBylineText']?['runs']?[0]?['text'],
      thumbnails: thumbnails,
      views: lengthText == null
          ? "Views ${videoRenderer?['viewCountText']?['runs']?[0]?['text']}"
          : simpleText,
    );
  }

  static VideoModel _fromCompactVideoRenderer(Map<String, dynamic> map) {
    final renderer = map['compactVideoRenderer'];
    final thumbnails = <ThumbnailModel>[];

    renderer?['thumbnail']['thumbnails']?.forEach((thumbnail) {
      thumbnails.add(ThumbnailModel(
        url: thumbnail['url'],
        width: thumbnail['width'],
        height: thumbnail['height'],
      ));
    });

    return VideoModel(
      videoId: renderer?['videoId'],
      title: renderer?['title']?['simpleText'],
      duration: renderer?['lengthText']?['simpleText'],
      thumbnails: thumbnails,
      channelName: renderer?['shortBylineText']?['runs']?[0]?['text'],
      views: renderer?['viewCountText']?['simpleText'],
    );
  }

  static VideoModel _fromGridVideoRenderer(Map<String, dynamic> map) {
    final renderer = map['gridVideoRenderer'];
    final simpleText = renderer?['shortViewCountText']?['simpleText'];
    final thumbnails = <ThumbnailModel>[];

    renderer?['thumbnail']['thumbnails']?.forEach((thumbnail) {
      thumbnails.add(ThumbnailModel(
        url: thumbnail['url'],
        width: thumbnail['width'],
        height: thumbnail['height'],
      ));
    });

    return VideoModel(
      videoId: renderer?['videoId'],
      title: renderer?['title']?['runs']?[0]?['text'],
      duration: renderer?['thumbnailOverlays']?[0]
          ?['thumbnailOverlayTimeStatusRenderer']?['text']?['simpleText'],
      thumbnails: thumbnails,
      views: simpleText ?? "???",
    );
  }
}

@freezed
class ThumbnailModel  with _$ThumbnailModel {
  const factory ThumbnailModel({
    String? url,
    int? width,
    int? height,
  }) = _ThumbnailModel;

  factory ThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailModelFromJson(json);
}
