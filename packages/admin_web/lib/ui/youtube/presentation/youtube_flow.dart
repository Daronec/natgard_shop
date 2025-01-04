import 'package:admin_web/ui/youtube/di/youtube_scope.dart';
import 'package:shared/imports.dart';

import 'youtube_screen.dart';

class YouTubeFlow extends StatelessWidget {
  /// {@macro feature_example_flow.class}
  const YouTubeFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DiScope<IYouTubeScope>(
      factory: YouTubeScope.create,
      onDispose: (scope) => scope.dispose(),
      child: const YouTubeScreen(),
    );
  }
}
