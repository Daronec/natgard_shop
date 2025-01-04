import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:shared/imports.dart';
import 'package:shared/widgets/audio_player_widget.dart';
import 'package:shared/widgets/you_tube_widget.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('data')
            // ...List.generate(
            //   videoLinks.length,
            //   (index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: SizedBox(
            //         width: size.width - 40,
            //         height: ((size.width - 40) / 16) * 9,
            //         child: WebViewWidget(
            //           link: videoLinks[index],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // ...List.generate(
            //   videoCodes.length,
            //   (index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: SizedBox(
            //         width: size.width - 40,
            //         height: ((size.width - 40) / 16) * 9,
            //         child: AppHtmlWidget(
            //           code: videoCodes[index],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // ...List.generate(
            //   videoIds.length,
            //   (index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: SizedBox(
            //         width: size.width - 40,
            //         height: ((size.width - 40) / 16) * 9,
            //         child: YouTubeWidget(
            //           id: videoIds[index],
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
