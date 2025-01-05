import 'package:admin_web/ui/audio/presentation/widgets/add_audio.dart';
import 'package:admin_web/ui/audio/presentation/widgets/audio_list.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'audio_wm.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            UnionStateListenableBuilder(
                unionStateListenable: wm.audioState,
                loadingBuilder: (_, __) => const Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicatorWidget(),
                    ),
                failureBuilder: (_, ex, ___) => Text(
                      ex.toString(),
                    ),
                builder: (context, audioState) {
                  return audioState.maybeMap(
                    orElse: () => const SizedBox(),
                    list: () => Column(
                      children: [
                        _HeaderWidget(wm: wm),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: UnionStateListenableBuilder(
                            unionStateListenable: wm.audio,
                            loadingBuilder: (_, data) => Stack(
                              children: [
                                if (data != null && data.isNotEmpty)
                                  AudioList(
                                    wm: wm,
                                    audio: data,
                                    deleteAudio: (value) {
                                      wm.deleteAudio(value);
                                    },
                                  ),
                                const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: CircularProgressIndicatorWidget(),
                                ),
                              ],
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
                        ),
                      ],
                    ),
                    add: () => AddAudio(
                      wm: wm,
                      onAdd: (audioDto) async {
                        await wm.addAudio(audioDto);
                      },
                    ),
                  );
                }),
            UnionStateListenableBuilder(
              unionStateListenable: wm.audioUploaded,
              loadingBuilder: (_, __) => const Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicatorWidget(),
              ),
              failureBuilder: (_, ex, ___) => Text(
                ex.toString(),
              ),
              builder: (_, audioUploaded) {
                return audioUploaded.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            audioUploaded.length,
                            (index) {
                              return SizedBox(
                                width: 200,
                                child: ListTile(
                                  tileColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      width: 1,
                                      color: AppColors.darkGrey,
                                    ),
                                  ),
                                  leading: const Icon(
                                    Icons.upload,
                                    color: AppColors.primary,
                                  ),
                                  title: Text(
                                    audioUploaded[index],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  trailing: const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicatorWidget(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    required this.wm,
    super.key,
  });

  final IAudioWM wm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          title: 'Добавить файл',
          color: AppColors.primary,
          textColor: Colors.white,
          onPressed: () {
            wm.changeAudioState();
          },
          isDisabled: false,
        ),
      ],
    );
  }
}
