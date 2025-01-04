import 'package:client_mobile/ui/audio/di/audio_scope.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:shared/imports.dart';

import 'audio_screen.dart';

class AudioFlow extends StatelessWidget {
  /// {@macro feature_example_flow.class}
  const AudioFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DiScope<IAudioScope>(
      factory: AudioScope.create,
      onDispose: (scope) => scope.dispose(),
      child: const AppScaffold(
        appBar: CustomAppBar(
          title: 'Аудио',
          showBackButton: false,
        ),
        child: AudioScreen(),
      ),
    );
  }
}
