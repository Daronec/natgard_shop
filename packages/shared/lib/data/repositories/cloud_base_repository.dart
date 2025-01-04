import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/core/architecture/domain/entity/failure.dart';
import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';

final class CloudBaseRepository implements ICloudBaseRepository {
  late FirebaseFirestore db;
  late FirebaseStorage storage;

  CloudBaseRepository() {
    db = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
  }

  @override
  RequestOperation<List<AudioDto>> getAudioData() async {
    List<AudioDto> audioList = [];
    try {
      await db.collection("audio").get().then(
        (doc) {
          if (doc.docs.isNotEmpty) {
            audioList.addAll(
              doc.docs.map(
                (e) => AudioDto.fromJson(e.data()),
              ),
            );
          }
        },
        onError: (err) => print('Documents: $err'),
      );
      return Result.ok(audioList);
    } on DioException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
  }

  @override
  Future<bool> addAudio(AudioDto value) async {
    try {

    } on FirebaseException catch (error, s) {
      debugPrint('ADD_AUDIO_ERROR: $error');
      return false;
    } on Object catch (error, s) {
      debugPrint('ADD_AUDIO_ERROR: $error');
      return false;
    }
    return false;
  }

  @override
  RequestOperation<bool> deleteAudio(AudioDto value) async {
    try {
      print('CLOUD_DELETE_FILE: ${value.id}');
      await db.collection("audio").doc(value.id).delete().then((v) {
        return const Result.ok(true);
      });
    } on DioException catch (error, s) {
      print('CLOUD_ERROR: $error');
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      print('CLOUD_ERROR: $error');
      return Result.failed(Failure(original: error, trace: s));
    }
    return const Result.ok(false);
  }

  @override
  RequestOperation<bool> updateAudio(AudioDto value) async {
    try {
      debugPrint('UPDATE_AUDIO_REQUEST: ${value.id}');
      final ref = db.collection("audio").doc(value.id);
      await ref.update(value.toJson()).then(
        (doc) {
          debugPrint('UPDATE_AUDIO_RESPONSE: TRUE');
          return const Result.ok(true);
        },
        onError: (err) => print('Documents: $err'),
      );
    } on DioException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
    return const Result.ok(false);
  }

  @override
  RequestOperation<AudioDto> getAudio(String name) async {
    try {
      await db.collection("audio").get().then(
        (doc) {
          if (doc.docs.isNotEmpty) {}
        },
        onError: (err) => print('Documents: $err'),
      );
      return Result.ok(AudioDto());
    } on DioException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
  }
}
