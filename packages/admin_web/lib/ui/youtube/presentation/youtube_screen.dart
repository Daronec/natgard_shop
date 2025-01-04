import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:shared/imports.dart';
import 'package:union_state/union_state.dart';

import 'youtube_wm.dart';

/// {@template feature_example_screen.class}
/// FeatureExampleScreen.
/// {@endtemplate}
class YouTubeScreen extends ElementaryWidget<IYouTubeWM> {
  /// {@macro feature_example_screen.class}
  const YouTubeScreen({
    super.key,
    WidgetModelFactory wmFactory = defaultYouTubeWMFactory,
  }) : super(wmFactory);

  @override
  Widget build(IYouTubeWM wm) {
    return Column(
      children: [
        AppTextField(
          width: 300,
          height: 50,
          hintText: 'ID канала (@namechannel)',
          textController: wm.searchTextController,
          onChange: (text) {
            if (text.length > 5) {
              wm.getVideos(text);
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        UnionStateListenableBuilder(
          unionStateListenable: wm.state,
          builder: (_, data) => GridView.count(
            shrinkWrap: true,
            crossAxisCount: 5,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            padding: const EdgeInsets.all(20),
            children: [
              ...data.map(
                (e) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                      image: e.thumbnails != null && e.thumbnails!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                e.thumbnails!.first.url!,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
          loadingBuilder: (_, __) => const CircularProgressIndicator(),
          failureBuilder: (_, ex, ___) => Text(
            ex.toString(),
          ),
        ),
      ],
    );
  }
}
