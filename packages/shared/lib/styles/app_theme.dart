import 'package:shared/imports.dart';

import 'app_text_styles.dart';

/// AppTheme
abstract class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppTextTheme.textTheme,
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    splashColor: Colors.transparent,
    canvasColor: AppColors.background,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.primary,
      inversePrimary: AppColors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.secondary,
      tertiary: AppColors.darkGrey,
      error: AppColors.error,
      onError: AppColors.error,
      surface: AppColors.darkGreen,
      onSurface: AppColors.darkGreen,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
    ),
    menuBarTheme: const MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(AppColors.white),
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.white,
    ),

    /// Slider theme
    sliderTheme: SliderThemeData(
      trackShape: const RectangularSliderTrackShape(),
      trackHeight: 2,
      overlayShape: SliderComponentShape.noThumb,
      activeTrackColor: AppColors.darkGreen,
      activeTickMarkColor: const Color(0xffef615c),
      inactiveTrackColor: const Color(0xffc0c0c0),
      inactiveTickMarkColor: const Color(0xffc0c0c0),
      thumbColor: AppColors.primary,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
    ),

    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.background,
      todayBorder: BorderSide.none,
    ),

    /// Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.grey,
      indent: 0,
      endIndent: 0,
      thickness: 1,
    ),

    /// InputDecoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      prefixIconColor: AppColors.primary,
      suffixIconColor: AppColors.primary,
      isDense: true,
      isCollapsed: false,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      constraints: const BoxConstraints(
        minHeight: 38,
        minWidth: double.infinity,
        maxWidth: double.infinity,
      ),
      border: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.darkGrey,
        ),
      ),
      errorBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.error,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.darkGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.darkGrey,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.darkGrey,
        ),
      ),
    ),

    /// TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.yellowAccent,
        backgroundColor: AppColors.grey,
        textStyle: AppTextTheme.textTheme.bodyMedium,
      ),
    ),

    /// ElevatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary,
        foregroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      //   style: const ButtonStyle().copyWith(
      //     alignment: Alignment.center,
      //     shape: const MaterialStatePropertyAll(
      //       RoundedRectangleBorder(
      //         borderRadius: AppTheme.circularRadius,
      //       ),
      //     ),
      //     padding: const MaterialStatePropertyAll(
      //       EdgeInsets.symmetric(
      //         horizontal: AppTheme.offset,
      //         vertical: AppTheme.offset / 2,
      //       ),
      //     ),
      //     elevation: MaterialStateProperty.resolveWith(
      //           (states) {
      //         if (states.contains(MaterialState.disabled)) return 0;
      //         if (states.contains(MaterialState.hovered)) {
      //           return AppTheme.elevation;
      //         }
      //         return 0;
      //       },
      //     ),
      //     side: MaterialStateProperty.resolveWith(
      //           (states) {
      //         if (states.contains(MaterialState.disabled)) {
      //           return BorderSide(width: 1, color: AppColors.colorScheme.outline);
      //         }
      //         if (states.contains(MaterialState.hovered)) return BorderSide.none;
      //         return BorderSide.none;
      //       },
      //     ),
      //     backgroundColor: MaterialStateProperty.resolveWith(
      //           (states) {
      //         if (states.contains(MaterialState.disabled)) {
      //           return AppColors.colorScheme.onPrimary;
      //         }
      //         if (states.contains(MaterialState.hovered)) {
      //           return AppColors.colorScheme.primary.withOpacity(0.7);
      //         }
      //         return AppColors.colorScheme.primary;
      //       },
      //     ),
      //     shadowColor: MaterialStateProperty.resolveWith(
      //           (states) {
      //         if (states.contains(MaterialState.disabled)) {
      //           return AppColors.colorScheme.shadow;
      //         }
      //         if (states.contains(MaterialState.hovered)) {
      //           return AppColors.colorScheme.primary;
      //         }
      //         return AppColors.colorScheme.shadow;
      //       },
      //     ),
      //   ),
    ),

    /// Appbar theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
    ),

    ///  Navbar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      showSelectedLabels: true,
      backgroundColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTextTheme.textTheme.labelMedium!.copyWith(
        color: AppColors.primary,
        fontSize: 9,
      ),
      unselectedLabelStyle: AppTextTheme.textTheme.labelMedium!.copyWith(
        color: AppColors.text,
        fontWeight: FontWeight.w500,
        fontSize: 9,
      ),
      selectedItemColor: AppColors.background,
      unselectedItemColor: AppColors.background,
    ),

    /// Chip theme
    // chipTheme: ChipThemeData(
    //   padding: const EdgeInsets.all(AppTheme.radius),
    //   backgroundColor: AppColors.colorScheme.outline,
    //   disabledColor: AppColors.colorScheme.surface,
    //   selectedColor: AppColors.colorScheme.primary,
    //   checkmarkColor: AppColors.colorScheme.onPrimary,
    //   showCheckmark: false,
    //   labelStyle: AppTextTheme.textTheme.labelLarge,
    // ),

    /// Checkbox theme
    // checkboxTheme: CheckboxThemeData(
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(2)),
    //   ),
    //   checkColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return AppColors.colorScheme.onPrimary;
    //     }
    //     if (states.contains(MaterialState.disabled)) {
    //       return AppColors.colorScheme.outline;
    //     }
    //     if (states.contains(MaterialState.hovered)) {
    //       return AppColors.colorScheme.primary.withOpacity(0.3);
    //     }
    //     return AppColors.colorScheme.primary;
    //   }),
    //   side: BorderSide(width: 1, color: AppColors.colorScheme.outline),
    // ),

    /// Switch theme
    // switchTheme: SwitchThemeData(
    //   thumbColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return AppColors.colorScheme.onPrimary;
    //     }
    //     if (states.contains(MaterialState.disabled)) {
    //       return AppColors.colorScheme.outline;
    //     }
    //     if (states.contains(MaterialState.focused)) {
    //       return AppColors.colorScheme.onPrimary;
    //     }
    //     if (states.contains(MaterialState.hovered)) {
    //       return AppColors.colorScheme.onPrimary;
    //     }
    //     return AppColors.colorScheme.onPrimary;
    //   }),
    //   trackColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return AppColors.colorScheme.onError;
    //     }
    //     if (states.contains(MaterialState.disabled)) {
    //       return AppColors.colorScheme.outline;
    //     }
    //     if (states.contains(MaterialState.hovered)) {
    //       return AppColors.colorScheme.outline;
    //     }
    //     return AppColors.colorScheme.outline;
    //   }),
    // ),

    /// RadioButton theme
    // radioTheme: RadioThemeData(
    //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //   fillColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.disabled)) {
    //       return AppColors.colorScheme.outline;
    //     }
    //     if (states.contains(MaterialState.selected)) {
    //       return AppColors.colorScheme.primary;
    //     }
    //     if (states.contains(MaterialState.focused)) {
    //       return AppColors.colorScheme.primary;
    //     }
    //     if (states.contains(MaterialState.hovered)) {
    //       return AppColors.colorScheme.primary;
    //     }
    //     return AppColors.colorScheme.outline;
    //   }),
    //   visualDensity: const VisualDensity(
    //     horizontal: VisualDensity.minimumDensity,
    //     vertical: VisualDensity.minimumDensity,
    //   ),
    // ),

    /// Progress Indicator theme
    // progressIndicatorTheme: ProgressIndicatorThemeData(
    //   color: AppColors.colorScheme.primary,
    //   linearMinHeight: 1,
    //   refreshBackgroundColor: AppColors.colorScheme.outline,
    // ),

    /// Timepicker theme
    // timePickerTheme: TimePickerThemeData(
    //   backgroundColor: AppColors.colorScheme.background,
    // ),

    /// Card theme
    // cardTheme: CardTheme(
    //   clipBehavior: Clip.hardEdge,
    //   color: AppColors.colorScheme.onPrimary,
    //   elevation: AppTheme.elevation,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: AppTheme.circularRadius,
    //   ),
    // ),

    /// Drawer theme
    // drawerTheme: const DrawerThemeData(
    //   elevation: AppTheme.elevation,
    // ),

    /// Date theme
    // dataTableTheme: const DataTableThemeData(
    //   headingTextStyle: TextStyle(
    //     // color: AppColors.textDark,
    //     fontWeight: FontWeight.w700,
    //   ),
    // ),

    /// Icon theme
    // iconTheme: IconThemeData(
    //   color: AppColors.colorScheme.primary,
    //   size: AppTheme.iconSize,
    // ),

    /// TabBar theme
    // navigationBarTheme: NavigationBarThemeData(
    //   backgroundColor: AppColors.colorScheme.primary,
    //   labelTextStyle: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return const TextStyle(
    //         fontSize: 10,
    //         fontWeight: FontWeight.w500,
    //         letterSpacing: -0.5,
    //       );
    //     }
    //     return const TextStyle(
    //       fontSize: 10,
    //       fontWeight: FontWeight.w700,
    //       letterSpacing: -0.5,
    //     );
    //   }),
    // ),

    ///  FloatButton theme
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   elevation: AppTheme.elevation * 2,
    //   // iconSize: 55,
    //   // sizeConstraints: BoxConstraints(minWidth: 75, minHeight: 75, maxWidth: 75, maxHeight: 75),
    // ),

    /// Dialog theme
    // dialogTheme: DialogTheme(
    //   backgroundColor: AppColors.colorScheme.outline,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: AppTheme.circularRadius,
    //   ),
    // ),
  );
}

/// ElevatedButton deep theme
//
// ButtonStyle elevatedButtonOnError = const ButtonStyle().copyWith(
//   alignment: Alignment.center,
//   shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
//     borderRadius: AppTheme.circularRadius,
//   )),
//   padding: const MaterialStatePropertyAll(EdgeInsets.all(AppTheme.offset)),
//   elevation: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) return 0;
//     if (states.contains(MaterialState.hovered)) return AppTheme.elevation;
//     return 0;
//   }),
//   side: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return BorderSide(width: 1, color: AppColors.colorScheme.outline);
//     }
//     if (states.contains(MaterialState.hovered)) return BorderSide.none;
//     return BorderSide.none;
//   }),
//   backgroundColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.onPrimary;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.onError.withOpacity(0.7);
//     }
//     return AppColors.colorScheme.onError;
//   }),
//   shadowColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.shadow;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.onError;
//     }
//     return AppColors.colorScheme.shadow;
//   }),
// );
// ButtonStyle elevatedButtonError = const ButtonStyle().copyWith(
//   alignment: Alignment.center,
//   shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
//     borderRadius: AppTheme.circularRadius,
//   )),
//   padding: const MaterialStatePropertyAll(EdgeInsets.all(AppTheme.offset)),
//   elevation: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) return 0;
//     if (states.contains(MaterialState.hovered)) return AppTheme.elevation;
//     return 0;
//   }),
//   side: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return BorderSide(width: 1, color: AppColors.colorScheme.outline);
//     }
//     if (states.contains(MaterialState.hovered)) return BorderSide.none;
//     return BorderSide.none;
//   }),
//   backgroundColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.onPrimary;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.error.withOpacity(0.7);
//     }
//     return AppColors.colorScheme.error;
//   }),
//   shadowColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.shadow;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.error;
//     }
//     return AppColors.colorScheme.shadow;
//   }),
// );
// ButtonStyle elevatedButtonDisabled = const ButtonStyle().copyWith(
//   alignment: Alignment.center,
//   shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
//     borderRadius: AppTheme.circularRadius,
//   )),
//   padding: const MaterialStatePropertyAll(EdgeInsets.all(AppTheme.offset)),
//   elevation: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) return 0;
//     if (states.contains(MaterialState.hovered)) return AppTheme.elevation;
//     return 0;
//   }),
//   side: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return BorderSide(width: 1, color: AppColors.colorScheme.outline);
//     }
//     if (states.contains(MaterialState.hovered)) return BorderSide.none;
//     return BorderSide(width: 1, color: AppColors.colorScheme.outline);
//   }),
//   backgroundColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.outline;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.outline.withOpacity(0.7);
//     }
//     return AppColors.colorScheme.onPrimary;
//   }),
//   foregroundColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.onPrimary;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.onPrimary.withOpacity(0.7);
//     }
//     return AppColors.colorScheme.outline;
//   }),
//   shadowColor: MaterialStateProperty.resolveWith((states) {
//     if (states.contains(MaterialState.disabled)) {
//       return AppColors.colorScheme.onPrimary;
//     }
//     if (states.contains(MaterialState.hovered)) {
//       return AppColors.colorScheme.onPrimary;
//     }
//     return AppColors.colorScheme.shadow;
//   }),
// );
