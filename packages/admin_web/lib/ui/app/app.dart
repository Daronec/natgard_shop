import 'package:shared/imports.dart';

import 'bloc/app_bloc.dart';
import 'di/app_scope.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async => setState(
          () {
            debugPrint('APP_CLOSED');
          },
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appScope = context.read<IAppScope>();

    appScope.authRepository.currentUserStream.listen((value) {});
    handleAppLifecycleState(
      context: context,
      scope: appScope,
    );
    // FlutterNativeSplash.remove();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<AppBloc>(
        create: (context) => AppBloc(
          ctx: context,
          appScope: appScope,
        )..add(
            const AppEvent.initial(),
          ),
        child: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            state.mapOrNull(
              info: (info) {
                if (info.pageState == PageState.success) {
                  Navigator.pop(context);
                } else {
                  showMessage(
                    message: info.message,
                    type: info.pageState,
                  );
                }
              },
            );
          },
          builder: (context, state) {
            return state.maybeMap(
              loading: (data) {
                return const SplashScreen();
              },
              data: (data) {
                return widget.child;
              },
              orElse: () => const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          await resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        if (suspendingCallBack != null) {
          await suspendingCallBack!();
        }
        break;
    }
  }
}

handleAppLifecycleState({
  required BuildContext context,
  required IAppScope scope,
}) {
  SystemChannels.lifecycle.setMessageHandler(
    (String? msg) async {
      switch (msg) {
        case "AppLifecycleState.paused":


          break;
        case "AppLifecycleState.inactive":
          break;
        case "AppLifecycleState.resumed":
          break;
        default:
      }
      return null;
    },
  );
}
