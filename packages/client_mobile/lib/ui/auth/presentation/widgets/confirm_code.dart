import 'package:client_mobile/ui/auth/presentation/auth_wm.dart';
import 'package:shared/imports.dart';

class ConfirmCode extends StatelessWidget {
  const ConfirmCode({
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
        AppTextField(
          hintText: 'Код',
          labelText: 'Введите код указанный в письме',
          formKey: wm.codeFormKey,
          textController: wm.codeTextController,
          type: TextFieldType.number,
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          width: double.infinity,
          title: 'Продолжить',
          onPressed: () async {
            await wm.confirmCode();
          },
        ),
      ],
    );
  }
}
