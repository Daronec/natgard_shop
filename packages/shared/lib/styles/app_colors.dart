import 'package:flutter/material.dart';

/// ColorScheme
class AppColors {
  static const primary = Color(0xFF80b201);
  static const secondary = Color(0xFF63420c);
  static const background = Color(0xFFe8e8e8);
  static const text = Color(0xFF262626);
  static const lightGrey = Color(0xFFE1E5E8);
  static const grey = Color(0xFFB8C2C9);
  static const darkGrey = Color(0xFF949EA6);
  static const white = Color(0xFFFFFFFF);
  static const darkGreen = Color(0xFF5c8000);
  static const error = Color(0xFFFF747C);
  static const lightBlue = Color(0xFF79b3fd);
  static const blue = Colors.blue;
}

LinearGradient gradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.25, 1),
  colors: <Color>[
    AppColors.darkGreen,
    AppColors.primary,
  ],
  tileMode: TileMode.mirror,
);
LinearGradient gradientGrey = LinearGradient(
  begin: Alignment.topLeft,
  end: const Alignment(0.25, 1),
  colors: <Color>[
    AppColors.grey,
    AppColors.grey.withOpacity(0.5),
  ],
  tileMode: TileMode.mirror,
);

LinearGradient gradientButton = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[
    AppColors.darkGreen,
    AppColors.primary,

    // Color(0xffEF615C),
  ],
  tileMode: TileMode.clamp,
);
