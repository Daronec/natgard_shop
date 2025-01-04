import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'audio_wm.dart';
import 'widgets/audio_list.dart';

/// {@template feature_example_screen.class}
/// FeatureExampleScreen.
/// {@endtemplate}
class AudioScreen extends ElementaryWidget<IAudioWM> {
  /// {@macro feature_example_screen.class}
  const AudioScreen({
    super.key,
    WidgetModelFactory wmFactory = defaultAudioWMFactory,
  }) : super(wmFactory);

  @override
  Widget build(IAudioWM wm) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: UnionStateListenableBuilder(
        unionStateListenable: wm.audio,
        loadingBuilder: (_, data) => data != null && data.isNotEmpty
            ? AudioList(
                wm: wm,
                audio: data,
                deleteAudio: (value) {
                  wm.deleteAudio(value);
                },
              )
            : const Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicatorWidget(),
              ),
        failureBuilder: (_, ex, ___) => Text(
          ex.toString(),
        ),
        builder: (_, data) => AudioList(
          wm: wm,
          audio: data,
          deleteAudio: (value) {
            wm.deleteAudio(value);
          },
        ),
      ),
    );
  }
}
