import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class UsersModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;

  final _users = UnionStateNotifier<List<UserModel>>.new([]);
  final _result = UnionStateNotifier<bool>.new(false);

  /// State of screen.
  UnionStateNotifier<List<UserModel>> get users => _users;

  UnionStateNotifier<bool> get result => _result;

  /// {@macro feature_example_model.class}
  UsersModel({required super.logWriter})
      : db = FirebaseFirestore.instance,
        storage = FirebaseStorage.instance;

  @override
  void dispose() {
    _users.dispose();
    _result.dispose();
    super.dispose();
  }

  Future<void> getUsers() async {
    _users.loading(_users.value.data ?? []);
    List<UserModel> userList = [];
    await db.collection("users").get().then(
      (doc) {
        if (doc.docs.isNotEmpty) {
          userList.addAll(
            doc.docs.map(
              (e) => UserModel.fromJson(e.data()),
            ),
          );
        }
      },
      onError: (err) => print('Documents: $err'),
    );
    _users.content(userList);
  }
}
