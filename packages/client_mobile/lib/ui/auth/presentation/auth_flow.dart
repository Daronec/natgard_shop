import 'package:client_mobile/ui/audio/di/audio_scope.dart';
import 'package:client_mobile/ui/auth/di/auth_scope.dart';
import 'package:client_mobile/ui/profile/di/profile_scope.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:shared/imports.dart';

import 'auth_screen.dart';

class AuthFlow extends StatelessWidget {
  /// {@macro feature_example_flow.class}
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return DiScope<IAuthScope>(
      factory: AuthScope.create,
      onDispose: (scope) => scope.dispose(),
      child: const AuthScreen(),
    );
  }
}
