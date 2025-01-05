import 'dart:convert';

import 'package:admin_web/ui/audio/presentation/audio_flow.dart';
import 'package:admin_web/ui/audio/presentation/audio_screen.dart';
import 'package:admin_web/ui/home/home_screen.dart';
import 'package:admin_web/ui/users/presentation/users_flow.dart';
import 'package:admin_web/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:admin_web/ui/youtube/presentation/youtube_flow.dart';
import 'package:client_mobile/ui/catalog/catalog_screen.dart';
import 'package:client_mobile/ui/video/video_screen.dart';
import 'package:shared/imports.dart';

class Pages {
  static const String auth = 'auth';
  static const String user = 'user';
  static const String users = 'users';
  static const String catalog = 'catalog';
  static const String video = 'video';
  static const String videos = 'videos';
  static const String audio = '/';
}

class AppRouter {
  GoRouter get router => _goRouter;

  AppRouter();

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  String getInitialRoute() {
    String path = Pages.audio;
    final page = Preferences.getStringByKey('page');
    Preferences.removeKey('page');
    if (page != null) {
      path = '/$page';
    }
    return path;
  }

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: getInitialRoute(),
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          return AppScaffold(child: child);
        },
        routes: <RouteBase>[

          GoRoute(
            name: Pages.catalog,
            path: '/${Pages.catalog}',
            pageBuilder: (_, state) => _pageWrapper(
              state,
              child: const CatalogScreen(),
            ),
          ),
          GoRoute(
            name: Pages.video,
            path: '/${Pages.video}',
            pageBuilder: (_, state) => _pageWrapper(
              state,
              child: const VideoScreen(),
            ),
          ),
          GoRoute(
            name: Pages.videos,
            path: '/${Pages.videos}',
            pageBuilder: (_, state) => _pageWrapper(
              state,
              child: const YouTubeFlow(),
            ),
          ),
          GoRoute(
            name: Pages.audio,
            path: Pages.audio,
            pageBuilder: (_, state) => _pageWrapper(
              state,
              child: const AudioFlow(),
            ),
          ),
          GoRoute(
            name: Pages.users,
            path: '/${Pages.users}',
            pageBuilder: (_, state) => _pageWrapper(
              state,
              child: const UsersFlow(),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      final notificationData = Preferences.getStringByKey('notificationData') ?? '';
      final page = (notificationData.isNotEmpty && notificationData.contains('page'))
          ? jsonDecode(Preferences.getStringByKey('notificationData')!)['page']
          : null;
      final id = (notificationData.isNotEmpty && notificationData.contains('id'))
          ? jsonDecode(Preferences.getStringByKey('notificationData')!)['id']
          : null;
      Preferences.removeKey('page');
      Preferences.removeKey('id');
      Preferences.removeKey('notificationData');
      if (page != null) {
        return '/$page'
            "${id != null ? "/$id" : ''}";
      }
      if (state.uri.path.contains('https://enigma.ru')) {
        // if (state.matchedLocation.contains(Pages.anotherUser)) {
        //   return '/${Pages.anotherUser}/${state.pathParameters["id"]}';
        // }
        return state.matchedLocation;
      }
      // final tokens = await appScope.tokenStorage.read();
      // if (state.fullPath == '/profile' && tokens?.accessToken == null) {
      //   return '/${Pages.auth}';
      // }
      return null;
    },
    errorBuilder: (context, state) {
      return Center(
        child: Text(
          state.error.toString(),
        ),
      );
    },
  );
}

CustomTransitionPage _pageWrapper(state, {required Widget child}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    reverseTransitionDuration: const Duration(milliseconds: 0),
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
  );
}

CustomTransitionPage _sliderPageWrapper(state, {required Widget child}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    reverseTransitionDuration: const Duration(milliseconds: 400),
    transitionDuration: const Duration(milliseconds: 1000),
    transitionsBuilder: (_, a, __, c) {
      a = CurvedAnimation(curve: Curves.fastLinearToSlowEaseIn, parent: a, reverseCurve: Curves.fastOutSlowIn);
      return SlideTransition(
        position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(a),
        child: c,
      );
    },
  );
}

class SliderTransition extends PageRouteBuilder {
  final Widget page;

  SliderTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn, parent: animation, reverseCurve: Curves.fastOutSlowIn);
            return SlideTransition(
              position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
              child: page,
            );
          },
        );
}
