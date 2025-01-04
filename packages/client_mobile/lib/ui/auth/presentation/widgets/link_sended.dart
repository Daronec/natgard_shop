import 'package:client_mobile/ui/auth/presentation/auth_model.dart';
import 'package:client_mobile/ui/auth/presentation/auth_wm.dart';
import 'package:shared/imports.dart';

class LinkSended extends StatelessWidget {
  const LinkSended({
    super.key,
    required this.wm,
  });

  final IAuthWM wm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Assets.images.logo.image(
          package: 'shared',
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          'На указанный электронный адрес, отправлено письмо с ссылкой для подтверждения!',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 40,
        ),
        const Spacer(),
        AppButton(
          width: double.infinity,
          title: 'Войти',
          onPressed: () {
            wm.changeAuthState(AuthState.authentication);
          },
        ),
      ],
    );
  }
}
