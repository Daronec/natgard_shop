import 'package:admin_web/ui/auth/presentation/auth_wm.dart';
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
          height: 50,
        ),
        AppTextField(
          width: 300,
          hintText: 'Электронная почта',
          textController: wm.emailTextController,
        ),
        const SizedBox(
          height: 20,
        ),
        AppTextField(
          width: 300,
          hintText: 'Пароль',
          textController: wm.passwordTextController,
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          width: 300,
          title: 'Войти',
          onPressed: () async {
            await wm.login();
          },
        ),
      ],
    );
  }
}
