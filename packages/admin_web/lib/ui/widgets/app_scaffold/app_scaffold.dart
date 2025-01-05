import 'package:admin_web/source/routes.dart';
import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:admin_web/ui/widgets/app_scaffold/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared/imports.dart';

import 'app_scaffold_view_model.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    Key? key,
    required this.child,
    this.navBar = true,
    this.saveAreaTop = true,
    this.saveAreaBottom = false,
    this.showTutorial = false,
    this.horizontalPadding = 0,
    this.systemNavBarColor = Colors.white,
    this.appBar,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  final Widget child;
  final bool navBar;
  final bool saveAreaTop;
  final bool saveAreaBottom;
  final double horizontalPadding;
  final Color systemNavBarColor;
  final PreferredSizeWidget? appBar;
  final bool showTutorial;
  final bool? resizeToAvoidBottomInset;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  Map<String, dynamic> map = {};
  String? token;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocalNotificationStream.listen((event) async {
        if (event.isNotEmpty) {
          map = (event);
          localNotificationStream.add({});
          if (map.isNotEmpty) {
            notificationRouter();
          }
        }
      });
    });
    getToken(context);
    super.initState();
  }

  void notificationRouter() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        if (mounted) {
          context.goNamed(
            map["page"],
            pathParameters: {
              if (map.containsKey("id")) "id": map["id"]!,
            },
          );
          map.clear();
        }
      },
    );
  }

  void getToken(BuildContext context) async {
    final appScope = context.read<IAppScope>();
    final tokens = await appScope.tokenStorage.read();
    token = tokens?.accessToken;
  }

  String getTitle(BuildContext) {
    String title = '';
    final GoRouter route = GoRouter.of(context);
    final RouteMatch lastMatch = route.routerDelegate.currentConfiguration.last;
    final String location = lastMatch.matchedLocation;
    if (location == '/users') {
      title = 'Пользователи';
    }
    if (location == '/') {
      title = 'Аудио';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final viewModel = Provider.of<AppScaffoldViewModel>(context);
    getToken(context);
    String title = getTitle(context);
    return SafeArea(
      top: widget.saveAreaTop,
      bottom: widget.saveAreaBottom,
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          width: 200,
          child: Column(
            children: [
              DrawerHeader(
                child: Assets.images.logo.image(
                  package: 'shared',
                ),
              ),
              ...List.generate(
                navbarList().length,
                (index) {
                  return ListTile(
                    onTap: () {
                      viewModel.onItemTapped(
                        index,
                        context,
                        token,
                      );
                      _key.currentState!.closeDrawer();
                    },
                    leading: icons(
                        iconsType: navbarList()[index].icons,
                        active: index == viewModel.calculateSelectedIndex(context),
                        theme: theme),
                    titleTextStyle: theme.textTheme.bodyMedium,
                    title: Text(
                      navbarList()[index].label ?? '',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: widget.appBar ??
            AppBar(
              leading: InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Icon(Icons.menu),
              ),
              title: Text(title),
              actions: [
                AppButton(
                  height: 30,
                  width: 100,
                  title: 'Выйти',
                  color: theme.colorScheme.tertiaryContainer,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then((_) async {
                      final appScope = context.read<IAppScope>();
                      await appScope.tokenStorage.delete().then((_) {
                        context.pushNamed(Pages.auth.value);
                      });
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
        body: widget.child,
      ),
    );
  }
}
