import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IAudioScope].
/// {@endtemplate}
final class AudioScope extends DisposableObject implements IAudioScope {
  /// Factory constructor for [IAudioScope].
  factory AudioScope.create(BuildContext context) {
    return AudioScope();
  }

  /// {@macro feature_example_scope.class}
  AudioScope();
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IAudioScope implements IDisposableObject {}
