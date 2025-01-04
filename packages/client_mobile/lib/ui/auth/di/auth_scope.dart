import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IAuthScope].
/// {@endtemplate}
final class AuthScope extends DisposableObject implements IAuthScope {
  /// Factory constructor for [IAuthScope].
  factory AuthScope.create(BuildContext context) {
    return AuthScope();
  }

  /// {@macro feature_example_scope.class}
  AuthScope();
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IAuthScope implements IDisposableObject {}
