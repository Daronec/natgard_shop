import 'package:admin_web/source/routes.dart';
import 'package:admin_web/ui/widgets/app_scaffold/constants/constants.dart';
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
    // final appScope = context.read<IAppScope>();
    // final tokens = await appScope.tokenStorage.read();
    // token = tokens?.accessToken;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final viewModel = Provider.of<AppScaffoldViewModel>(context);
    getToken(context);
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
                        active:
                            index == viewModel.calculateSelectedIndex(context),
                        theme: theme),
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
              title: Text('Page'),
            ),
        body: widget.child,
        // bottomNavigationBar: widget.navBar
        //     ? DecoratedBox(
        //         decoration: BoxDecoration(
        //           boxShadow: [
        //             BoxShadow(
        //               color: theme.colorScheme.onBackground.withOpacity(0.15),
        //               // blurRadius: 30,
        //             )
        //           ],
        //         ),
        //         child: BottomNavigationBar(
        //           currentIndex: viewModel.calculateSelectedIndex(context),
        //           onTap: (int index) => viewModel.onItemTapped(
        //             index,
        //             context,
        //             token,
        //           ),
        //           items: [
        //             BottomNavigationBarItem(
        //               icon: Padding(
        //                 key: UniqueKey(),
        //                 padding: const EdgeInsets.only(
        //                   bottom: 5,
        //                   top: 5,
        //                 ),
        //                 child: icons(
        //                   iconsType: navbarList()[0].icons!,
        //                   active: false,
        //                   theme: theme,
        //                 ),
        //               ),
        //               activeIcon: Padding(
        //                 key: UniqueKey(),
        //                 padding: const EdgeInsets.only(
        //                   bottom: 5,
        //                   top: 5,
        //                 ),
        //                 child: icons(
        //                   iconsType: navbarList()[0].icons!,
        //                   active: true,
        //                   theme: theme,
        //                 ),
        //               ),
        //               label: navbarList()[0].label,
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Padding(
        //                 key: UniqueKey(),
        //                 padding: const EdgeInsets.only(
        //                   bottom: 5,
        //                   top: 5,
        //                 ),
        //                 child: icons(
        //                   iconsType: navbarList()[1].icons!,
        //                   active: false,
        //                   theme: theme,
        //                 ),
        //               ),
        //               activeIcon: Padding(
        //                 key: UniqueKey(),
        //                 padding: const EdgeInsets.only(
        //                   bottom: 5,
        //                   top: 5,
        //                 ),
        //                 child: icons(
        //                   iconsType: navbarList()[1].icons!,
        //                   active: true,
        //                   theme: theme,
        //                 ),
        //               ),
        //               label: navbarList()[1].label,
        //             ),
        //           ],
        //         ),
        //       )
        //     : null,
      ),
    );
  }
}
