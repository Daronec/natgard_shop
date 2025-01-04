import 'package:client_mobile/ui/audio/di/audio_scope.dart';
import 'package:client_mobile/ui/profile/di/profile_scope.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:shared/imports.dart';

import 'profile_screen.dart';

class ProfileFlow extends StatelessWidget {
  /// {@macro feature_example_flow.class}
  const ProfileFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DiScope<IProfileScope>(
      factory: ProfileScope.create,
      onDispose: (scope) => scope.dispose(),
      child: const ProfileScreen(),
    );
  }
}
