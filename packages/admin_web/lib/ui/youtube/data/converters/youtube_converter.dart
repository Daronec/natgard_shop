import 'package:shared/imports.dart';

/// Converter for [IpEntity].
typedef IYouTubeConverter = Converter<List<VideoModel>?, List<VideoModel>?>;

/// {@template category_converter.class}
/// Implementation of [IYouTubeConverter].
/// {@endtemplate}
final class YouTubeConverter extends IYouTubeConverter {
  /// {@macro category_converter.class}
  const YouTubeConverter();

  @override
  List<VideoModel>? convert(List<VideoModel>? input) {
    return input;
  }
}
