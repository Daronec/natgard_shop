import 'package:client_mobile/ui/profile/presentation/profile_wm.dart';
import 'package:flutter/material.dart';
import 'package:shared/data/models/user_model/user_model.dart';
import 'package:shared/imports.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
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
          lableText(
            context: context,
            title: 'ФИО',
          ),
          Text(
            '${user?.name != null ? '${user?.name} ' : ''}'
            '${user?.patronymic != null ? '${user?.patronymic} ' : ''}'
            '${user?.surname ?? ''}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          lableText(
            context: context,
            title: 'Телефон',
          ),
          Text(
            user?.phone ?? 'Не указан',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          lableText(
            context: context,
            title: 'Email',
          ),
          Text(
            user?.email ?? 'Не указан',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          lableText(
            context: context,
            title: 'Адрес',
          ),
          Text(
            user?.address ?? 'Не указан',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          lableText(
            context: context,
            title: 'Дата рождения',
          ),
          Text(
            user?.birthday?.formatDate ?? 'Не указана',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 20,
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
