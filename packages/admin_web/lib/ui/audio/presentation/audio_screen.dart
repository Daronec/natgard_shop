import 'package:admin_web/ui/audio/presentation/widgets/add_audio_dialog.dart';
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
            Column(
              children: [
                _HeaderWidget(
                  onAdd: (audioDto) async {
                    await wm.addAudio(audioDto);
                  },
                  wm: wm,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
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
                ),
              ],
            ),
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
                return Column(
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
                );
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
    super.key,
    required this.onAdd,
    required this.wm,
  });

  final Function(AudioDto) onAdd;
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
            showDialog(
              context: context,
              builder: (ctx) {
                return AddAudioDialog(
                  onAdd: onAdd,
                  wm: wm,
                );
              },
            );
          },
          isDisabled: false,
        ),
      ],
    );
  }
}
