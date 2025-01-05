import 'package:admin_web/source/routes.dart';
import 'package:shared/imports.dart';

class AppScaffoldViewModel extends ChangeNotifier {
  /// Calculates the index of the selected navbar item
  int calculateSelectedIndex(
    BuildContext context,
  ) {
    final GoRouter route = GoRouter.of(context);
    final RouteMatch lastMatch = route.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch ? lastMatch.matches : route.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString().replaceAll('/', '');
    int index = 0;
    if (location.startsWith(Pages.users.name)) {
      index = 0;
    }
    if (location.startsWith(Pages.audio.name)) {
      index = 1;
    }

    return index;
  }

  /// Happens when you press the item
  void onItemTapped(
    int index,
    BuildContext context,
    String? token,
  ) {
    switch (index) {
      case 0:
        context.pushNamed(token != null ? Pages.users.value : Pages.auth.value);
        break;
      case 1:
        context.pushNamed(token != null ? Pages.audio.value : Pages.auth.value);
        break;
    }
  }
}
