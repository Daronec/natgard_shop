import 'package:client_mobile/ui/auth/presentation/auth_wm.dart';
import 'package:shared/imports.dart';

class RegistrationBody extends StatelessWidget {
  const RegistrationBody({
    super.key,
    required this.wm,
  });

  final IAuthWM wm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          AppTextField(
            hintText: 'Ваше имя',
            labelText: 'Ваше имя',
            formKey: wm.nameFormKey,
            textController: wm.nameTextController,
            type: TextFieldType.name,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hintText: 'Электронная почта',
            labelText: 'Электронная почта',
            formKey: wm.emailFormKey,
            textController: wm.emailTextController,
            type: TextFieldType.email,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hintText: 'Пароль',
            labelText: 'Пароль',
            obscureText: true,
            formKey: wm.passwordFormKey,
            textController: wm.passwordTextController,
            type: TextFieldType.password,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            hintText: 'Повторите пароль',
            labelText: 'Повторите пароль',
            obscureText: true,
            formKey: wm.confirmPasswordFormKey,
            textController: wm.confirmPasswordTextController,
            type: TextFieldType.password,
          ),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            width: double.infinity,
            title: 'Регистрация',
            onPressed: () async {
              await wm.registration();
            },
          ),
        ],
      ),
    );
  }
}
