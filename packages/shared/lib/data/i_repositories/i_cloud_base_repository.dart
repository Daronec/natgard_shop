import 'package:shared/imports.dart';

abstract interface class ICloudBaseRepository {
  RequestOperation<List<AudioDto>> getAudioData();
  RequestOperation<AudioDto> getAudio(String name);
  Future<bool> addAudio(AudioDto value);
  RequestOperation<bool?> updateAudio(AudioDto value);
  RequestOperation<bool> deleteAudio(AudioDto value);
}
