import 'package:flutter/material.dart';
import 'package:shared/data/models/user_model/user_model.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.tertiaryContainer,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('${user.name} ${user.patronymic} ${user.surname}'),
          ),
          Expanded(
            flex: 1,
            child: Text(user.email ?? ''),
          ),
          Expanded(
            flex: 1,
            child: Text(user.phone ?? ''),
          ),
        ],
      ),
    );
  }
}