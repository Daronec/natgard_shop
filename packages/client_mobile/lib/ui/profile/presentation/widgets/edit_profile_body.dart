import 'package:client_mobile/ui/profile/presentation/profile_wm.dart';
import 'package:shared/imports.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({
    super.key,
    this.user,
    required this.wm,
  });

  final UserModel? user;
  final IProfileWM wm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: AppAvatar(
              size: 100,
              imageId: user?.avatar ?? '',
              onTap: () => wm.editAvatar(),
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          AppTextField(
            labelText: 'Имя',
            hintText: 'Имя',
            textController: wm.nameTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            labelText: 'Телефон',
            hintText: 'Телефон',
            textController: wm.phoneTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            labelText: 'Email',
            hintText: 'Email',
            textController: wm.emailTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            labelText: 'Адрес',
            hintText: 'Адрес',
            textController: wm.addressTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppTextField(
            labelText: 'Дата рождения',
            hintText: 'Дата рождения',
            textController: wm.birthdayTextController,
          ),
          const SizedBox(
            height: 20,
          ),
          AppButton(
            width: double.infinity,
            title: 'Сохранить',
            onPressed: () {
              wm.editUser();
            },
          ),
        ],
      ),
    );
  }

  Widget lableText({
    required BuildContext context,
    required String title,
  }) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.tertiary,
      ),
    );
  }
}
