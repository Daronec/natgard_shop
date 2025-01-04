import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:shared/imports.dart';
import 'package:shared/source/disposable_object/i_disposable_object.dart';

/// {@template feature_example_scope.class}
/// Implementation of [IYouTubeScope].
/// {@endtemplate}
final class YouTubeScope extends DisposableObject implements IYouTubeScope {
  @override
  final IYouTubeRepository repository;

  /// Factory constructor for [IYouTubeScope].
  factory YouTubeScope.create(BuildContext context) {
    final appScope = context.read<IAppScope>();

    return YouTubeScope(
      YouTubeRepository(
        service: YouTubeService(
          appScope.dio,
          baseUrl: baseUrl,
        ),
      ),
    );
  }

  /// {@macro feature_example_scope.class}
  YouTubeScope(this.repository);
}

/// Scope dependencies of the FeatureExample feature.
abstract interface class IYouTubeScope implements IDisposableObject {
  /// FeatureExampleRepository.
  IYouTubeRepository get repository;
}
