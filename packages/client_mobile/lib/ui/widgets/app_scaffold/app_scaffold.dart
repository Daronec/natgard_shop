import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';

import 'app_scaffold_view_model.dart';
import 'constants/constants.dart';

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
    final appScope = context.read<IAppScope>();
    final tokens = await appScope.tokenStorage.read();
    token = tokens?.accessToken;
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
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: widget.appBar,
        body: widget.child,
        bottomNavigationBar: widget.navBar
            ? DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onBackground.withOpacity(0.15),
                      // blurRadius: 30,
                    )
                  ],
                ),
                child: BottomNavigationBar(
                  selectedLabelStyle: theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.primary,
                    fontSize: 9,
                  ),
                  unselectedLabelStyle: theme.textTheme.labelMedium!.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                    fontSize: 9,
                  ),
                  currentIndex: viewModel.calculateSelectedIndex(context),
                  onTap: (int index) => viewModel.onItemTapped(
                    index,
                    context,
                    token,
                  ),
                  items: [
                    ...List.generate(
                      navbarList().length,
                      (index) {
                        return BottomNavigationBarItem(
                          icon: Padding(
                            key: UniqueKey(),
                            padding: const EdgeInsets.only(
                              bottom: 5,
                              top: 5,
                            ),
                            child: icons(
                              iconsType: navbarList()[index].icons,
                              active: false,
                              theme: theme,
                            ),
                          ),
                          activeIcon: Padding(
                            key: UniqueKey(),
                            padding: const EdgeInsets.only(
                              bottom: 5,
                              top: 5,
                            ),
                            child: icons(
                              iconsType: navbarList()[index].icons,
                              active: true,
                              theme: theme,
                            ),
                          ),
                          label: navbarList()[index].label,
                        );
                      },
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
