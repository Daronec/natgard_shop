import 'package:admin_web/source/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared/imports.dart';

import 'app.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(
        textScaleFactor: 1,
      ),
      child: FutureBuilder(
        future: Provider.of<AppRouter>(
          context,
          listen: false,
        ).getRouter(context),
        builder: (context, router) {
          if (router.connectionState == ConnectionState.done) {
            return MaterialApp.router(
              title: 'Natgard',
              checkerboardOffscreenLayers: false,
              debugShowCheckedModeBanner: false,
              routerConfig: router.data,
              locale: const Locale('ru'),
              theme: AppTheme.theme.copyWith(brightness: Brightness.dark),
              supportedLocales: const <Locale>[Locale('ru')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, widget) {
                return GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: App(
                    child: widget ?? const SplashScreen(),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
