/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/test.mp3
  String get test => 'assets/audio/test.mp3';

  /// List of all assets
  List<String> get values => [test];
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/.gitkeep
  String get aGitkeep => 'assets/fonts/.gitkeep';

  /// List of all assets
  List<String> get values => [aGitkeep];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/photo_placeholder.svg
  String get photoPlaceholder => 'assets/icons/photo_placeholder.svg';

  /// File path: assets/icons/test_svg.svg
  String get testSvg => 'assets/icons/test_svg.svg';

  /// List of all assets
  List<String> get values => [photoPlaceholder, testSvg];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/test.png
  AssetGenImage get test => const AssetGenImage('assets/images/test.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo, test];
}

class $AssetsLauncherIconGen {
  const $AssetsLauncherIconGen();

  /// File path: assets/launcher_icon/icon_background.png
  AssetGenImage get iconBackground =>
      const AssetGenImage('assets/launcher_icon/icon_background.png');

  /// File path: assets/launcher_icon/icon_background_dev.png
  AssetGenImage get iconBackgroundDev =>
      const AssetGenImage('assets/launcher_icon/icon_background_dev.png');

  /// File path: assets/launcher_icon/icon_foreground.png
  AssetGenImage get iconForeground =>
      const AssetGenImage('assets/launcher_icon/icon_foreground.png');

  /// File path: assets/launcher_icon/icon_foreground_dev.png
  AssetGenImage get iconForegroundDev =>
      const AssetGenImage('assets/launcher_icon/icon_foreground_dev.png');

  /// File path: assets/launcher_icon/icon_rectangle.png
  AssetGenImage get iconRectangle =>
      const AssetGenImage('assets/launcher_icon/icon_rectangle.png');

  /// File path: assets/launcher_icon/icon_rectangle_dev.png
  AssetGenImage get iconRectangleDev =>
      const AssetGenImage('assets/launcher_icon/icon_rectangle_dev.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        iconBackground,
        iconBackgroundDev,
        iconForeground,
        iconForegroundDev,
        iconRectangle,
        iconRectangleDev
      ];
}

class $AssetsSplashGen {
  const $AssetsSplashGen();

  /// File path: assets/splash/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/splash/splash.png');

  /// File path: assets/splash/splash_android12.png
  AssetGenImage get splashAndroid12 =>
      const AssetGenImage('assets/splash/splash_android12.png');

  /// File path: assets/splash/splash_dark.png
  AssetGenImage get splashDark =>
      const AssetGenImage('assets/splash/splash_dark.png');

  /// File path: assets/splash/splash_dark_android12.png
  AssetGenImage get splashDarkAndroid12 =>
      const AssetGenImage('assets/splash/splash_dark_android12.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [splash, splashAndroid12, splashDark, splashDarkAndroid12];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLauncherIconGen launcherIcon = $AssetsLauncherIconGen();
  static const $AssetsSplashGen splash = $AssetsSplashGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
