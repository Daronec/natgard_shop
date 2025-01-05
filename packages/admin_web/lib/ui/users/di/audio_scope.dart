import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IUsersScope].
/// {@endtemplate}
final class UsersScope extends DisposableObject implements IUsersScope {
  /// Factory constructor for [IUsersScope].
  factory UsersScope.create(BuildContext context) {
    return UsersScope();
  }

  /// {@macro feature_example_scope.class}
  UsersScope();
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IUsersScope implements IDisposableObject {}
