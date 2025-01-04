// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioDtoImpl _$$AudioDtoImplFromJson(Map<String, dynamic> json) =>
    _$AudioDtoImpl(
      id: json['id'] as String?,
      youtubeId: json['youtubeId'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      videoLink: json['videoLink'] as String?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      fileLink: json['fileLink'] as String?,
    );

Map<String, dynamic> _$$AudioDtoImplToJson(_$AudioDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'youtubeId': instance.youtubeId,
      'name': instance.name,
      'title': instance.title,
      'videoLink': instance.videoLink,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'fileLink': instance.fileLink,
    };
