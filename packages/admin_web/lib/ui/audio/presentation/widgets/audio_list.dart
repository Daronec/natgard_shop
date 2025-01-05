import 'package:admin_web/ui/audio/presentation/audio_wm.dart';
import 'package:admin_web/ui/audio/presentation/widgets/add_audio.dart';
import 'package:shared/imports.dart';

class AudioList extends StatelessWidget {
  const AudioList({
    super.key,
    required this.audio,
    required this.deleteAudio,
    required this.wm,
  });

  final List<AudioDto> audio;
  final Function(AudioDto) deleteAudio;
  final IAudioWM wm;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: audio.length,
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AddAudio(
                  audio: audio[index],
                  onEdit: (value) async {
                    await wm.editAudio(value).then((result) {});
                  },
                  wm: wm,
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 1,
              color: AppColors.darkGrey,
            ),
          ),
          leading: const Icon(Icons.audiotrack),
          title: Text(
            audio[index].title ?? '',
          ),
          trailing: InkWell(
            onTap: () {
              deleteAudio(audio[index]);
            },
            child: const Icon(
              Icons.delete,
              color: AppColors.darkGrey,
            ),
          ),
        );
      },
    );
  }
}
