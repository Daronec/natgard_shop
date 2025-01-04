import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/core/architecture/domain/entity/failure.dart';
import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';

final class FirebaseStorageRepository implements IFirebaseStorageRepository {
  late FirebaseStorage db;

  FirebaseStorageRepository() {
    db = FirebaseStorage.instance;
  }

  @override
  RequestOperation<TaskSnapshot> uploadFile({
    required String id,
    required Uint8List bytes,
  }) async {
    try {
      debugPrint('UPLOAD_FILE_REQUEST: audio/$id');
      final reference = db.ref().child('audio/$id');
      final stream = await reference.putData(bytes);
      debugPrint('UPLOAD_FILE_STATE: ${stream.state}');
      return Future.value(Result.ok(stream));
    } on FirebaseException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
  }

  @override
  RequestOperation<Stream<TaskSnapshot>> getFile(String name) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = "${appDocDir.absolute}/$name";
      final file = File(filePath);
      final islandRef = db.ref().child(name);
      final stream = islandRef.writeToFile(file);
      return Result.ok(stream.snapshotEvents);
    } on DioException catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      return Result.failed(Failure(original: error, trace: s));
    }
  }

  @override
  RequestOperation<bool> deleteFile(String name) async {
    try {
      print('STORAGE_DELETE_FILE: audio/$name');
      final desertRef = db.ref().child("audio/$name");
      await desertRef.delete().then((_) {
        return const Result.ok(true);
      });
    } on DioException catch (error, s) {
      print('STORAGE_ERROR: $error');
      return Result.failed(Failure(original: error, trace: s));
    } on Object catch (error, s) {
      print('STORAGE_ERROR: $error');
      return Result.failed(Failure(original: error, trace: s));
    }
    return const Result.ok(false);
  }
}
