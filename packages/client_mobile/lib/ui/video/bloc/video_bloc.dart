import 'package:shared/imports.dart';

part 'video_event.dart';
part 'video_state.dart';
part 'video_bloc.freezed.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(const VideoState.initial()) {
    on<VideoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
