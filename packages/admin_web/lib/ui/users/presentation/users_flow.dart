import 'package:admin_web/ui/audio/di/audio_scope.dart';
import 'package:admin_web/ui/users/di/audio_scope.dart';
import 'package:shared/imports.dart';

import 'users_screen.dart';

class UsersFlow extends StatelessWidget {
  const UsersFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DiScope<IUsersScope>(
      factory: UsersScope.create,
      onDispose: (scope) => scope.dispose(),
      child: const UsersScreen(),
    );
  }
}
