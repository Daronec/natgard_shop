import 'package:client_mobile/ui/auth/presentation/auth_model.dart';
import 'package:client_mobile/ui/auth/presentation/widgets/authentication_body.dart';
import 'package:client_mobile/ui/auth/presentation/widgets/link_sended.dart';
import 'package:client_mobile/ui/auth/presentation/widgets/recovery_password_body.dart';
import 'package:client_mobile/ui/auth/presentation/widgets/registration_body.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'auth_wm.dart';

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
    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: UnionStateListenableBuilder(
            unionStateListenable: wm.authState,
            loadingBuilder: (_, authState) => Stack(
                  children: [
                    if (authState != null)
                      authState.maybeMap(
                        orElse: () => const SizedBox(),
                        authentication: () => AuthenticationBody(wm: wm),
                        registration: () => RegistrationBody(wm: wm),
                        recoveryPassword: () => RecoveryPasswordBody(wm: wm),
                        linkSended: () => LinkSended(wm: wm),
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
                      registration: () => RegistrationBody(wm: wm),
                      recoveryPassword: () => RecoveryPasswordBody(wm: wm),
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
                registration: () => RegistrationBody(wm: wm),
                recoveryPassword: () => RecoveryPasswordBody(wm: wm),
                linkSended: () => LinkSended(wm: wm),
              );
            }),
      ),
    );
  }
}
