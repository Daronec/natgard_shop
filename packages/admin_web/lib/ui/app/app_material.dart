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
      child: Builder(
        builder: (context) {
          final GoRouter goRouter = Provider.of<AppRouter>(
            context,
            listen: false,
          ).router;

          return MaterialApp.router(
            title: 'Natgard',
            checkerboardOffscreenLayers: false,
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter,
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
        },
      ),
    );
  }
}
