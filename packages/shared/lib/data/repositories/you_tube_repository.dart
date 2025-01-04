import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:shared/core/architecture/domain/entity/failure.dart';
import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';

import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;

final class YouTubeRepository implements IYouTubeRepository {
  final YouTubeService _service;

  YouTubeRepository({
    required YouTubeService service,
  }) : _service = service;

  @override
  RequestOperation<List<VideoModel>> getVideosChannel({
    required String channelId,
  }) async {
    List<VideoModel>? videoList = [];
    try {
      final result = await _service.fetchChannelData(channelId);
      Document root = parse(result);
      final scriptText = root
          .querySelectorAll('script')
          .map((e) => e.text)
          .toList(growable: false);
      var initialData = scriptText
          .firstWhereOrNull((e) => e.contains('var ytInitialData = '));
      initialData ??= scriptText
          .firstWhereOrNull((e) => e.contains('window["ytInitialData"] ='));
      var jsonMap = extractJson(initialData!);
      if (jsonMap != null) {
        var contents = jsonMap
            .get('contents')
            ?.get('twoColumnBrowseResultsRenderer')
            ?.getList('tabs')?[1]
            .get('tabRenderer')
            ?.get('content')
            ?.get('richGridRenderer')
            ?.getList('contents')
            ?.firstOrNull
            ?.get('itemSectionRenderer')
            ?.getList('contents');
        var contentList = contents!.toList();
        videoList.addAll(
          contentList
              .map(
                (element) => VideoModel.fromMap(element),
              )
              .toList(),
        );
        return Result.ok(videoList);
      }
    } on DioException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
    return Result.ok(videoList);
    // Document root = parse(response);
    // final scriptText = root
    //     .querySelectorAll('script')
    //     .map((e) => e.text)
    //     .toList(growable: false);
    // var initialData =
    //     scriptText.firstWhereOrNull((e) => e.contains('var ytInitialData = '));
    // initialData ??= scriptText
    //     .firstWhereOrNull((e) => e.contains('window["ytInitialData"] ='));
    // var jsonMap = extractJson(initialData!);
    // if (jsonMap != null) {
    //   var contents = jsonMap
    //       .get('contents')
    //       ?.get('twoColumnBrowseResultsRenderer')
    //       ?.getList('tabs')?[1]
    //       .get('tabRenderer')
    //       ?.get('content')
    //       ?.get('sectionListRenderer')
    //       ?.getList('contents')
    //       ?.firstOrNull
    //       ?.get('itemSectionRenderer')
    //       ?.getList('contents')
    //       ?.firstOrNull
    //       ?.get('gridRenderer')
    //       ?.getList('items');
    //   var contentList = contents!.toList();
    //   videoList.addAll(
    //     contentList
    //         .map(
    //           (element) => VideoModel.fromMap(element),
    //         )
    //         .toList(),
    //   );
    //   return videoList;
    // }
  }
}

Map<String, dynamic>? extractJson(String s, [String separator = '']) {
  final index = s.indexOf(separator) + separator.length;
  if (index > s.length) {
    return null;
  }

  final str = s.substring(index);

  final startIdx = str.indexOf('{');
  var endIdx = str.lastIndexOf('}');

  while (true) {
    try {
      return jsonDecode(str.substring(startIdx, endIdx + 1))
          as Map<String, dynamic>;
    } on FormatException {
      endIdx = str.lastIndexOf(str.substring(0, endIdx));
      if (endIdx == 0) {
        return null;
      }
    }
  }
}

extension GetOrNullMap on Map {
  /// Get a map inside a map
  Map<String, dynamic>? get(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    return v;
  }

  /// Get a value inside a map.
  /// If it is null this returns null, if of another type this throws.
  T? getT<T>(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    if (v is! T) {
      throw Exception('Invalid type: ${v.runtimeType} should be $T');
    }
    return v;
  }

  /// Get a List<Map<String, dynamic>>> from a map.
  List<Map<String, dynamic>>? getList(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    if (v is! List<dynamic>) {
      throw Exception('Invalid type: ${v.runtimeType} should be of type List');
    }

    return (v.toList()).cast<Map<String, dynamic>>();
  }
}

/// List Utility.
extension ListUtil<E> on Iterable<E> {
  /// Same as [elementAt] but if the index is higher than the length returns
  /// null
  E? elementAtSafe(int index) {
    if (index >= length) {
      return null;
    }
    return elementAt(index);
  }
}
