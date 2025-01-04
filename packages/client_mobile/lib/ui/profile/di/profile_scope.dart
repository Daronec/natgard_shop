import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IProfileScope].
/// {@endtemplate}
final class ProfileScope extends DisposableObject implements IProfileScope {
  /// Factory constructor for [IProfileScope].
  factory ProfileScope.create(BuildContext context) {
    return ProfileScope();
  }

  /// {@macro feature_example_scope.class}
  ProfileScope();
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IProfileScope implements IDisposableObject {}
