import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@EnumAssist()
enum AuthState {
  authentication,
  registration,
  linkSended,
  success,
  recoveryPassword;

  T map<T>({
    required T Function() authentication,
    required T Function() registration,
    required T Function() linkSended,
    required T Function() recoveryPassword,
    required T Function() success,
  }) {
    switch (this) {
      case AuthState.authentication:
        return authentication();
      case AuthState.registration:
        return registration();
      case AuthState.linkSended:
        return linkSended();
      case AuthState.recoveryPassword:
        return recoveryPassword();
      case AuthState.success:
        return success();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? authentication,
    T Function()? registration,
    T Function()? linkSended,
    T Function()? recoveryPassword,
    T Function()? success,
  }) =>
      map<T>(
        authentication: authentication ?? orElse,
        registration: registration ?? orElse,
        linkSended: linkSended ?? orElse,
        recoveryPassword: recoveryPassword ?? orElse,
        success: success ?? orElse,
      );
}

final class AuthModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;
  late FirebaseAuth firebaseAuth;
  late IAppScope appScope;

  AuthCredential? credential;

  final _user = UnionStateNotifier<UserModel?>.new(null);

  UnionStateNotifier<UserModel?> get user => _user;

  final _state = UnionStateNotifier<bool>.new(true);

  UnionStateNotifier<bool> get state => _state;

  final _authState = UnionStateNotifier<AuthState>.new(AuthState.registration);

  UnionStateNotifier<AuthState> get authState => _authState;

  final _phoneTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _codeTextController = TextEditingController();

  TextEditingController get phoneTextController => _phoneTextController;

  TextEditingController get emailTextController => _emailTextController;

  TextEditingController get passwordTextController => _passwordTextController;

  TextEditingController get confirmPasswordTextController => _confirmPasswordTextController;

  TextEditingController get nameTextController => _nameTextController;

  TextEditingController get codeTextController => _codeTextController;

  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  final _nameFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> get emailFormKey => _emailFormKey;

  GlobalKey<FormState> get passwordFormKey => _passwordFormKey;

  GlobalKey<FormState> get confirmPasswordFormKey => _confirmPasswordFormKey;

  GlobalKey<FormState> get nameFormKey => _nameFormKey;

  GlobalKey<FormState> get codeFormKey => _codeFormKey;

  AuthModel({
    required IAppScope scope,
    required super.logWriter,
  })  : db = FirebaseFirestore.instance,
        storage = FirebaseStorage.instance,
        firebaseAuth = FirebaseAuth.instance,
        appScope = scope;

  @override
  void init() async {
    final checkAppToken = await FirebaseAppCheck.instance.getToken();
    print('APP_CHECK_TOKEN: $checkAppToken');
    super.init();
  }

  @override
  void dispose() {
    _user.dispose();
    _state.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    _state.loading();
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      firebaseAuth.authStateChanges().listen((User? value) async {
        if (value != null && value.emailVerified) {
          await value.getIdToken().then((value) async {
            if (value != null) {
              print('TOKEN: $value');

              await appScope.tokenStorage
                  .write(
                AuthTokenPair(
                  accessToken: value,
                ),
              )
                  .then((_) {
                _authState.content(AuthState.success);
              });
            }
          });
        } else {
          showMessage(
            message: 'Электронный адрес не подтверждён',
            type: PageState.error,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    _state.content(false);
  }

  Future<void> registration() async {
    _authState.loading(_authState.value.data);
    try {
      if ((_nameFormKey.currentState?.validate() ?? false) &&
          (_emailFormKey.currentState?.validate() ?? false) &&
          (_passwordFormKey.currentState?.validate() ?? false) &&
          (_confirmPasswordFormKey.currentState?.validate() ?? false)) {
        if (_passwordTextController.text != _confirmPasswordTextController.text) {
          _authState.failure(
            Exception('Пароли не совпадают'),
            _authState.value.data,
          );
        } else {
          final response = await firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text,
          );
          credential = response.credential;
          await firebaseAuth.currentUser!.updateDisplayName(_nameTextController.text).then((_) async {
            final user = firebaseAuth.currentUser;
            if (user != null) {
              UserModel data = UserModel(
                name: user.displayName,
                email: user.email,
                phone: user.phoneNumber,
              );
              final ref = db.collection("users");
              final map = data.toJson();
              ref.add(map).then((doc) async {
                map["id"] = doc.id;
                doc.update(map).then((_) async {
                  await firebaseAuth.setLanguageCode('ru');
                  await user.sendEmailVerification().then((_) {
                    _authState.content(AuthState.linkSended);
                  });
                });
              });
            }
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _authState.failure(
          Exception('Предоставленный пароль слишком простой.'),
          _authState.value.data,
        );
      } else if (e.code == 'email-already-in-use') {
        _authState.failure(
          Exception('Учетная запись для этого адреса электронной почты уже существует.'),
          _authState.value.data,
        );
      }
    } catch (e) {
      print(e);
    }
    _state.content(false);
  }

  Future<void> getCurrentUser() async {
    _state.loading();

    _state.content(false);
  }

  void changeAuthState(AuthState state) {
    _authState.content(state);
  }
}
