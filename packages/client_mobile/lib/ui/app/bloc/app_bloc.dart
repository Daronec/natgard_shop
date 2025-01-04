import 'package:client_mobile/ui/app/di/app_scope.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared/imports.dart';

part 'app_event.dart';

part 'app_state.dart';

part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late FirebaseAuth firebaseAuth;

  AppBloc({
    required BuildContext ctx,
    required IAppScope appScope,
  })  : context = ctx,
        _appScope = appScope,
        super(const AppState.initial()) {
    on<_InitialEvent>(_onInitialEvent);
  }

  late BuildContext context;
  late IAuthRepository authRepo;
  late final IAppScope _appScope;

  void _onInitialEvent(
    _InitialEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(const _LoadingAppState());
      firebaseAuth = FirebaseAuth.instance;
      authRepo = _appScope.authRepository;
      emit(const _LoadingAppState());
      FirebaseAuth.instance.authStateChanges().listen((User? value) async {
        print('USER: ${value?.uid}');
        if (value != null) {
          await value.getIdToken().then((value) async {
            if (value != null) {
              await _appScope.tokenStorage.write(AuthTokenPair(
                accessToken: value,
              ));
            }
          });
        }
      });
      emit(const _DataAppState());
    } on DioException catch (err) {
      if ((err.response?.statusCode ?? 0) > 500) {
        emit(
          const _InfoAppState(
            message: 'Что-то пошло не так, попробуйте позже',
            pageState: PageState.error,
          ),
        );
      } else if (err.response?.statusCode != 401 && err.response?.statusCode != 403) {
        emit(
          _InfoAppState(
            message: err.response?.data["message"].toString() ?? '',
            pageState: PageState.error,
          ),
        );
      }
      emit(const _DataAppState());
    } catch (ex) {
      emit(
        _InfoAppState(
          message: ex.toString(),
          pageState: PageState.error,
        ),
      );
      emit(const _DataAppState());
    }
  }
}
