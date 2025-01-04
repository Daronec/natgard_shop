import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared/imports.dart';

abstract interface class IFirebaseStorageRepository {
  RequestOperation<TaskSnapshot> uploadFile({
    required String id,
    required Uint8List bytes,
  });

  RequestOperation<Stream<TaskSnapshot>> getFile(String path);

  RequestOperation<bool> deleteFile(String name);
}
