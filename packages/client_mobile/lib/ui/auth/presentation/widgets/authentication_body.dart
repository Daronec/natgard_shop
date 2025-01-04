import 'package:client_mobile/ui/auth/presentation/auth_wm.dart';
import 'package:shared/imports.dart';

class AuthenticationBody extends StatelessWidget {
  const AuthenticationBody({
    super.key,
    required this.wm,
  });

  final IAuthWM wm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Assets.images.logo.image(
          package: 'shared',
        ),
        const SizedBox(
          height: 20,
        ),
        const Spacer(),
        AppTextField(
          hintText: 'Электронная почта',
          textController: wm.emailTextController,
        ),
        const SizedBox(
          height: 20,
        ),
        AppTextField(
          hintText: 'Пароль',
          textController: wm.passwordTextController,
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          width: double.infinity,
          title: 'Войти',
          onPressed: () async {
            await wm.login();
          },
        ),
      ],
    );
  }
}
