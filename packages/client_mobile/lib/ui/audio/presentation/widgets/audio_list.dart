import 'package:client_mobile/ui/audio/presentation/audio_wm.dart';
import 'package:client_mobile/ui/audio/presentation/widgets/audio_item.dart';
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
      itemBuilder: (ctx, index) {
        return AudioItem(
          audio: audio[index],
        );
      },
    );
  }
}
