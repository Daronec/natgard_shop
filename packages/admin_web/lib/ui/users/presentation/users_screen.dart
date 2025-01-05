import 'package:admin_web/ui/users/presentation/widgets/user_item.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'users_wm.dart';

/// {@template feature_example_screen.class}
/// FeatureExampleScreen.
/// {@endtemplate}
class UsersScreen extends ElementaryWidget<IUsersWM> {
  /// {@macro feature_example_screen.class}
  const UsersScreen({
    super.key,
    WidgetModelFactory wmFactory = defaultUsersWMFactory,
  }) : super(wmFactory);

  @override
  Widget build(IUsersWM wm) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: UnionStateListenableBuilder(
          unionStateListenable: wm.users,
          loadingBuilder: (_, data) => const CircularProgressIndicatorWidget(),
          failureBuilder: (_, ex, ___) => Text(
            ex.toString(),
          ),
          builder: (_, users) {
            return Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'ФИО',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Электронная почта',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Телефон',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: users.length,
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    return UserItem(
                      user: users[index],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
