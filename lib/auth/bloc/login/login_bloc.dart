import 'package:auth/auth/data/authentication_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(loginStatus: LoginStatus.initial, result: '')) {
    on<LoginButtonPressed>(
        (event, emit) async => await _onLoginButtonPressed(emit, event));

    on<GoogleSingInPressed>(
        (event, emit) async => await _onGoogleSignOnPressed(emit));
  }

  Future<void> _onLoginButtonPressed(
      Emitter<LoginState> emit, LoginButtonPressed event) async {
    emit(const LoginState(loginStatus: LoginStatus.loading));

    try {
      await AuthenticationData().login(event.email, event.password);
      emit(const LoginState(loginStatus: LoginStatus.success, result: ''));
    } catch (error) {
      emit(LoginState(
          loginStatus: LoginStatus.failure, result: error.toString()));
    }
  }

  Future<void> _onGoogleSignOnPressed(Emitter<LoginState> emit) async {
    {
      emit(const LoginState().copyWith(loginStatus: LoginStatus.loading));

      try {
        await AuthenticationData().signInWithGoogle();
        emit(const LoginState(loginStatus: LoginStatus.success, result: ''));
      } catch (error) {
        emit(LoginState(
            loginStatus: LoginStatus.failure,
            result: error
                .toString())); // TODO Нужен toast для уведомдение пользователя
      }
    }
  }
}
