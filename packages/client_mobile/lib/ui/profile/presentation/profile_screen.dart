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
    return Column(
      children: [
        AppTextField(
          textController: TextEditingController(),
        ),
      ],
    );
  }
}
