import 'package:client_mobile/source/routes.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold_view_model.dart';
import 'package:shared/imports.dart';

import 'app_material.dart';
import 'di/app_scope.dart';

/// {@template app_flow.class}
/// Entry point for the application.
/// {@endtemplate}
class AppFlow extends StatelessWidget {
  /// {@macro app_flow.class}
  const AppFlow({
    required this.appScope,
    super.key,
  });

  /// {@macro app_scope.class}
  final IAppScope appScope;

  @override
  Widget build(BuildContext context) {
    return Nested(
      child: const AppMaterial(),
      children: [
        DiScope<IAppScope>(factory: (_) => appScope),
        Provider<AppRouter>(
          create: (_) => AppRouter(),
        ),
        ChangeNotifierProvider<AppScaffoldViewModel>(
          create: (_) => AppScaffoldViewModel(),
        ),

      ],
    );
  }
}
