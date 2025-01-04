// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoModelImpl _$$VideoModelImplFromJson(Map<String, dynamic> json) =>
    _$VideoModelImpl(
      videoId: json['videoId'] as String?,
      duration: json['duration'] as String?,
      title: json['title'] as String?,
      channelName: json['channelName'] as String?,
      views: json['views'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => ThumbnailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VideoModelImplToJson(_$VideoModelImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'duration': instance.duration,
      'title': instance.title,
      'channelName': instance.channelName,
      'views': instance.views,
      'thumbnails': instance.thumbnails,
    };

_$ThumbnailModelImpl _$$ThumbnailModelImplFromJson(Map<String, dynamic> json) =>
    _$ThumbnailModelImpl(
      url: json['url'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ThumbnailModelImplToJson(
        _$ThumbnailModelImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
