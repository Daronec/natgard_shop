import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IAudioScope].
/// {@endtemplate}
final class AudioScope extends DisposableObject implements IAudioScope {
  @override
  final ICloudBaseRepository cloudRepository;
  @override
  final IFirebaseStorageRepository storageRepository;

  /// Factory constructor for [IAudioScope].
  factory AudioScope.create(BuildContext context) {
    return AudioScope(
      cloudRepository: CloudBaseRepository(),
      storageRepository: FirebaseStorageRepository(),
    );
  }

  /// {@macro feature_example_scope.class}
  AudioScope({
    required this.cloudRepository,
    required this.storageRepository,
  });
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IAudioScope implements IDisposableObject {
  ICloudBaseRepository get cloudRepository;

  IFirebaseStorageRepository get storageRepository;
}
