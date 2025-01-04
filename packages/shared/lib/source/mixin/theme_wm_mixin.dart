import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// A mixin with [AppColorScheme].
/// Used with [WidgetModel] subclasses.
mixin ThemeWMMixin implements ThemeIModelMixin {
  late TextTheme _textScheme;

  @override
  TextTheme get textScheme => _textScheme;
}

/// A mixin for [ThemeWMMixin] for get [AppColorScheme].
mixin ThemeIModelMixin implements IWidgetModel {
  /// App text style scheme.
  TextTheme get textScheme;
}
