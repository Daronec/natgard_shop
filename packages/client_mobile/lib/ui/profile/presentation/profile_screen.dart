import 'package:client_mobile/ui/profile/presentation/profile_model.dart';
import 'package:client_mobile/ui/profile/presentation/widgets/edit_profile_body.dart';
import 'package:client_mobile/ui/profile/presentation/widgets/profile_body.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:elementary/elementary.dart';
import 'package:shared/imports.dart';
import 'profile_wm.dart';

/// {@template feature_example_screen.class}
/// FeatureExampleScreen.
/// {@endtemplate}
class ProfileScreen extends ElementaryWidget<IProfileWM> {
  /// {@macro feature_example_screen.class}
  const ProfileScreen({
    super.key,
    WidgetModelFactory wmFactory = defaultAudioWMFactory,
  }) : super(wmFactory);

  @override
  Widget build(IProfileWM wm) {
    return AppScaffold(
      appBar: CustomAppBar(
        title: 'Личный кабинет',
        backgroundColor: Colors.white,
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () => wm.changeProfileState(),
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      child: UnionStateListenableBuilder(
          unionStateListenable: wm.profileState,
          loadingBuilder: (_, profileState) => const SizedBox(),
          failureBuilder: (_, ex, ___) => Text(
                ex.toString(),
              ),
          builder: (context, profileState) {
            return UnionStateListenableBuilder(
              unionStateListenable: wm.user,
              loadingBuilder: (_, data) => Stack(
                children: [
                  if (data != null || profileState != null)
                    profileState!.maybeMap(
                      orElse: () => const SizedBox(),
                      view: () => ProfileBody(
                        user: data,
                        wm: wm,
                      ),
                      edit: () => EditProfileBody(wm: wm),
                    ),
                  const CircularProgressIndicatorWidget(),
                ],
              ),
              failureBuilder: (_, ex, ___) => Text(
                ex.toString(),
              ),
              builder: (_, user) => profileState!.maybeMap(
                orElse: () => const SizedBox(),
                view: () => ProfileBody(
                  user: user,
                  wm: wm,
                ),
                edit: () => EditProfileBody(wm: wm),
              ),
            );
          }),
    );
  }
}
