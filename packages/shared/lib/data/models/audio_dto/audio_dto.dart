import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_dto.freezed.dart';

part 'audio_dto.g.dart';

@freezed
class AudioDto with _$AudioDto {
  const factory AudioDto({
    String? id,
    String? youtubeId,
    String? name,
    String? title,
    String? videoLink,
    String? description,
    String? shortDescription,
    String? fileLink,
    @JsonKey(
      includeToJson: false,
      includeFromJson: false,
    )
    Uint8List? bytes,
  }) = _AudioDto;

  factory AudioDto.fromJson(Map<String, dynamic> json) =>
      _$AudioDtoFromJson(json);
}
