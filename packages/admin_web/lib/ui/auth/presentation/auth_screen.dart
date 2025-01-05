import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'auth_model.dart';
import 'auth_wm.dart';
import 'widgets/authentication_body.dart';

/// {@template feature_example_screen.class}
/// FeatureExampleScreen.
/// {@endtemplate}
class AuthScreen extends ElementaryWidget<IAuthWM> {
  /// {@macro feature_example_screen.class}
  const AuthScreen({
    super.key,
    WidgetModelFactory wmFactory = defaultAudioWMFactory,
  }) : super(wmFactory);

  @override
  Widget build(IAuthWM wm) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: UnionStateListenableBuilder(
          unionStateListenable: wm.authState,
          loadingBuilder: (_, authState) => Stack(
            alignment: Alignment.center,
                children: [
                  if (authState != null)
                    authState.maybeMap(
                      orElse: () => const SizedBox(),
                      authentication: () => AuthenticationBody(wm: wm),
                    ),
                  const CircularProgressIndicatorWidget(),
                ],
              ),
          failureBuilder: (_, ex, authState) {
            if (ex != null) {
              showMessage(
                message: ex.toString().replaceAll('Exception: ', ''),
                type: PageState.error,
              );
            }
            return authState != null
                ? authState.maybeMap(
                    orElse: () => const SizedBox(),
                    authentication: () => AuthenticationBody(wm: wm),

                  )
                : const SizedBox();
          },
          builder: (context, authState) {
            if (authState == AuthState.success) {
              wm.goToHome();
            }
            return authState.maybeMap(
              orElse: () => const SizedBox(),
              authentication: () => AuthenticationBody(wm: wm),
            );
          }),
    );
  }
}
