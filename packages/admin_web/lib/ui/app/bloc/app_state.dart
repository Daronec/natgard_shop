part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _InitialAppState;

  const factory AppState.loading() = _LoadingAppState;

  const factory AppState.data() = _DataAppState;

  const factory AppState.info({
    required String message,
    required PageState pageState,
  }) = _InfoAppState;
}
