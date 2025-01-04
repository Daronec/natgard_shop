import 'package:client_mobile/ui/profile/presentation/profile_model.dart';
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
            onPressed: () {
              wm.changeProfileState(ProfileState.edit);
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      child: UnionStateListenableBuilder(
        unionStateListenable: wm.user,
        loadingBuilder: (_, data) => Stack(
          children: [
            if (data != null)
              ProfileBody(
                user: data,
                wm: wm,
              ),
            const CircularProgressIndicatorWidget(),
          ],
        ),
        failureBuilder: (_, ex, ___) => Text(
          ex.toString(),
        ),
        builder: (_, user) => ProfileBody(
          user: user,
          wm: wm,
        ),
      ),
    );
  }
}
