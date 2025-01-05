import 'package:shared/imports.dart';

/// Converter for [IpEntity].
typedef IAudioConverter = Converter<List<AudioDto>?, List<AudioDto>?>;

/// {@template category_converter.class}
/// Implementation of [IYouTubeConverter].
/// {@endtemplate}
final class AudioConverter extends IAudioConverter {
  /// {@macro category_converter.class}
  const AudioConverter();

  @override
  List<AudioDto>? convert(List<AudioDto>? input) {
    return input;
  }
}
