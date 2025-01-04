import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class ProfileModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;

  final _user = UnionStateNotifier<UserModel?>.new(null);

  UnionStateNotifier<UserModel?> get user => _user;

  final _state = UnionStateNotifier<bool>.new(true);

  UnionStateNotifier<bool> get state => _state;

  final _phoneTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _patronymicTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _birthdayTextController = TextEditingController();

  TextEditingController get phoneTextController => _phoneTextController;

  TextEditingController get emailTextController => _emailTextController;

  TextEditingController get nameTextController => _nameTextController;

  TextEditingController get surnameTextController => _surnameTextController;

  TextEditingController get patronymicTextController => _patronymicTextController;

  TextEditingController get addressTextController => _addressTextController;

  TextEditingController get birthdayTextController => _birthdayTextController;

  ProfileModel({
    required super.logWriter,
  })  : db = FirebaseFirestore.instance,
        storage = FirebaseStorage.instance;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCurrentUser() async {
    _state.loading();

    _state.content(false);
  }
}
