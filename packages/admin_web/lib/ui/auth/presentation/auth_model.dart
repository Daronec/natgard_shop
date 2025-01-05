import 'package:admin_web/ui/app/di/app_scope.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@EnumAssist()
enum AuthState {
  authentication,
  success;

  T map<T>({
    required T Function() authentication,
    required T Function() success,
  }) {
    switch (this) {
      case AuthState.authentication:
        return authentication();
      case AuthState.success:
        return success();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? authentication,
    T Function()? success,
  }) =>
      map<T>(
        authentication: authentication ?? orElse,
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

  final _authState = UnionStateNotifier<AuthState>.new(AuthState.authentication);

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
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    _authState.loading(_authState.value.data);
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      firebaseAuth.authStateChanges().listen((User? authUser) async {
        if (authUser != null && authUser.emailVerified) {
          await authUser.getIdToken().then((value) async {
            if (value != null) {
              print('TOKEN: $value');
              await db.collection("users").get().then(
                (doc) async {
                  if (doc.docs.isNotEmpty) {
                    for (var item in doc.docs) {
                      final map = item.data();
                      if (authUser.email == map["email"] && map["isAdmin"]) {
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
                    }
                  }
                },
                onError: (err) => print('Documents: $err'),
              );
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
  }
}
