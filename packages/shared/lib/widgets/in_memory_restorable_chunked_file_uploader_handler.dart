import 'package:admin_web/ui/audio/presentation/audio_wm.dart';
import 'package:en_file_uploader/en_file_uploader.dart';

/// Copied from [en_file_uploader example](https://pub.dev/packages/en_file_uploader/example)

class InMemoryRestorableChunkedFileUploadHandler extends RestorableChunkedFileUploadHandler {
  /// constructor
  InMemoryRestorableChunkedFileUploadHandler({
    required super.file,
    super.chunkSize,
  });

  @override
  Future<FileUploadPresentationResponse> present() {
    return Future.value(FileUploadPresentationResponse(id: '1'));
  }

  @override
  Future<FileUploadStatusResponse> status(
    FileUploadPresentationResponse presentation,
  ) {
    return Future.value(
      FileUploadStatusResponse(nextChunkOffset: 0),
    );
  }

  @override
  Future<void> uploadChunk(
    FileUploadPresentationResponse presentation,
    FileChunk chunk, {
    ProgressCallback? onProgress,
  }) async {
    final chunkFile = (await chunk.file.readAsBytes()).sublist(chunk.start, chunk.end);

    // backend.addChunk(
    //   presentation.id,
    //   chunkFile,
    // );
    return Future.value();
  }
}
