import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniLOLverse/domain/domain.dart';

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServiceInterface _authService;
  final UserDataServiceInterface _userDataService;

  AuthBloc(this._authService, this._userDataService) : super(AuthInitial()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.logIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authService.signUp(
        email: event.email,
        password: event.password,
      );

      await _userDataService.addUserData(
        email: event.email,
        name: event.email
      );

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}