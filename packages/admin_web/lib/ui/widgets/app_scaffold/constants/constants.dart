import 'package:shared/imports.dart';

/// Returns the navbar icon widget
Widget icons({
  required IconsType iconsType,
  required bool active,
  required ThemeData theme,
}) {
  switch (iconsType) {
    case IconsType.catalog:
      return Icon(
        Icons.menu,
        color: active ? AppColors.primary : AppColors.grey,
      );
    case IconsType.youtube:
      return Icon(
        Icons.video_library,
        color: active ? AppColors.primary : AppColors.grey,
      );
    case IconsType.users:
      return Icon(
        Icons.supervised_user_circle_outlined,
        color: active ? AppColors.primary : AppColors.grey,
      );
    case IconsType.audio:
      return Icon(
        Icons.audiotrack,
        color: active ? AppColors.primary : AppColors.grey,
      );
    default:
      return const SizedBox();
  }
}

/// Navbar's item list
List<NavbarEntity> navbarList() {
  return const [
    NavbarEntity(
      label: 'Пользователи',
      icons: IconsType.users,
    ),
    NavbarEntity(
      label: 'Аудио',
      icons: IconsType.audio,
    ),
  ];
}
