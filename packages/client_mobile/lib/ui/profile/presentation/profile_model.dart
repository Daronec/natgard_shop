import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@EnumAssist()
enum ProfileState {
  view,
  edit;

  T map<T>({
    required T Function() view,
    required T Function() edit,
  }) {
    switch (this) {
      case ProfileState.view:
        return view();
      case ProfileState.edit:
        return edit();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? view,
    T Function()? edit,
  }) =>
      map<T>(
        view: view ?? orElse,
        edit: edit ?? orElse,
      );
}

final class ProfileModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;
  late FirebaseAuth firebaseAuth;

  final _user = UnionStateNotifier<UserModel?>.new(null);

  final _profileState = UnionStateNotifier<ProfileState?>.new(ProfileState.view);

  UnionStateNotifier<UserModel?> get user => _user;

  UnionStateNotifier<ProfileState?> get profileState => _profileState;

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
        firebaseAuth = FirebaseAuth.instance,
        storage = FirebaseStorage.instance;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCurrentUser() async {
    _user.loading(_user.value.data);
    final authUser = firebaseAuth.currentUser;
    if (authUser != null) {
      await db.collection("users").get().then(
        (doc) {
          if (doc.docs.isNotEmpty) {
            for (var item in doc.docs) {
              final map = item.data();
              if (authUser.email == map["email"]) {
                final user = UserModel.fromJson(map);
                nameTextController.text = user.name ?? '';
                patronymicTextController.text = user.patronymic ?? '';
                surnameTextController.text = user.surname ?? '';
                phoneTextController.text = user.phone ?? '';
                emailTextController.text = user.email ?? '';
                addressTextController.text = user.address ?? '';
                birthdayTextController.text = user.birthday?.formatNumberDate ?? '';
                _user.content(user);
              }
            }
          }
        },
        onError: (err) => print('Documents: $err'),
      );
    }
  }

  void changeProfileState() {
    _profileState.content(_profileState.value.data == ProfileState.edit ? ProfileState.view : ProfileState.edit);
  }

  void editAvatar(XFile file) async {
    final reference = storage.ref().child('avatars/${file.name}');

    final stream = await reference.putData(await file.readAsBytes());
    await Future.delayed(const Duration(milliseconds: 200));
    stream.ref.getDownloadURL().then((link) async {
      final authUser = firebaseAuth.currentUser;
      await Future.delayed(const Duration(milliseconds: 200));
      await authUser?.updatePhotoURL(link).then((_) async {
        await Future.delayed(const Duration(milliseconds: 200));
        await db.collection("users").get().then(
          (doc) async {
            if (doc.docs.isNotEmpty) {
              for (var item in doc.docs) {
                final map = item.data();
                if (authUser.email == map["email"]) {
                  await Future.delayed(const Duration(milliseconds: 200));
                  final user = _user.value.data;
                  if (user != null) {
                    final ref = db.collection("users").doc(user.id);
                    map["avatar"] = link;
                    await Future.delayed(const Duration(milliseconds: 200));
                    await ref.update(map).then(
                      (doc) {
                        _user.content(UserModel.fromJson(map));
                      },
                      onError: (err) => debugPrint('Documents: $err'),
                    );
                  }
                }
              }
            }
          },
          onError: (err) => print('Documents: $err'),
        );
      });
    });
  }

  Future<void> editUser() async {
    _user.loading(_user.value.data);
    UserModel? user = _user.value.data;
    if (user != null) {
      user = user.copyWith(
        name: _nameTextController.text,
        patronymic: _patronymicTextController.text,
        surname: _surnameTextController.text,
        phone: _phoneTextController.text,
        email: _emailTextController.text,
        address: _addressTextController.text,
      );
      if (_birthdayTextController.text.isNotEmpty) {
        user = user.copyWith(
          birthday: _birthdayTextController.text.formatDateToDate,
        );
      }
      final ref = db.collection("users").doc(user.id);
      await ref.update(user.toJson()).then(
        (doc) {
          _user.content(user);
          _profileState.content(ProfileState.view);
        },
        onError: (err) => debugPrint('Documents: $err'),
      );
    }
  }
}
