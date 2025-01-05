import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:admin_web/ui/audio/presentation/audio_flow.dart';
import 'package:admin_web/ui/auth/presentation/auth_flow.dart';
import 'package:admin_web/ui/users/presentation/users_flow.dart';
import 'package:admin_web/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:admin_web/ui/youtube/presentation/youtube_flow.dart';
import 'package:client_mobile/ui/catalog/catalog_screen.dart';
import 'package:client_mobile/ui/video/video_screen.dart';
import 'package:shared/imports.dart';

enum Pages {
  auth('auth', 'Авторизация'),
  user('user', 'Личный кабинет'),
  users('users', 'Пользователи'),
  catalog('catalog', 'Каталог'),
  video('video', 'Видео'),
  videos('videos', 'Видео'),
  audio('/', 'Аудио');

  const Pages(this.value, this.name);

  final String value;
  final String name;
}

class AppRouter {
  AppRouter();

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  Future<String> getInitialRoute(BuildContext context) async {
    String path = Pages.audio.value;
    final appScope = context.read<IAppScope>();
    final tokens = await appScope.tokenStorage.read();
    if (tokens?.accessToken == null) {
      return '/${Pages.auth.value}';
    }
    return path;
  }

  Future<GoRouter> getRouter(BuildContext context) async {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: await getInitialRoute(context),
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
              name: Pages.catalog.value,
              path: '/${Pages.catalog.value}',
              pageBuilder: (_, state) => _pageWrapper(
                state,
                child: const CatalogScreen(),
              ),
            ),
            GoRoute(
              name: Pages.video.value,
              path: '/${Pages.video.value}',
              pageBuilder: (_, state) => _pageWrapper(
                state,
                child: const VideoScreen(),
              ),
            ),
            GoRoute(
              name: Pages.videos.value,
              path: '/${Pages.videos.value}',
              pageBuilder: (_, state) => _pageWrapper(
                state,
                child: const YouTubeFlow(),
              ),
            ),
            GoRoute(
              name: Pages.audio.value,
              path: Pages.audio.value,
              pageBuilder: (_, state) => _pageWrapper(
                state,
                child: const AudioFlow(),
              ),
            ),
            GoRoute(
              name: Pages.users.value,
              path: '/${Pages.users.value}',
              pageBuilder: (_, state) => _pageWrapper(
                state,
                child: const UsersFlow(),
              ),
            ),
          ],
        ),
        GoRoute(
          name: Pages.auth.value,
          path: '/${Pages.auth.value}',
          pageBuilder: (_, state) => _pageWrapper(
            state,
            child: const AuthFlow(),
          ),
        ),
      ],
      redirect: (context, state) async {
        // final notificationData = Preferences.getStringByKey('notificationData') ?? '';
        // final page = (notificationData.isNotEmpty && notificationData.contains('page'))
        //     ? jsonDecode(Preferences.getStringByKey('notificationData')!)['page']
        //     : null;
        // final id = (notificationData.isNotEmpty && notificationData.contains('id'))
        //     ? jsonDecode(Preferences.getStringByKey('notificationData')!)['id']
        //     : null;
        // Preferences.removeKey('page');
        // Preferences.removeKey('id');
        // Preferences.removeKey('notificationData');
        // if (page != null) {
        //   return '/$page'
        //       "${id != null ? "/$id" : ''}";
        // }
        final appScope = context.read<IAppScope>();
        final tokens = await appScope.tokenStorage.read();
        if (tokens?.accessToken == null) {
          return '/${Pages.auth.value}';
        }
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
