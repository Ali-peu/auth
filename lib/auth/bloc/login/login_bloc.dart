import 'dart:developer';

import 'package:auth/auth/data/authentication_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(
          loginStatus: LoginStatus.initial,
        )) {
    on<LoginButtonPressed>((event, emit) async {
      await _loginButtonPressed(emit, event);
    });

    on<ChangeLoginType>((event, emit) => _onChangeLoginType(event, emit));
    on<LoginWithEmail>((event, emit) => _onLoginWithEmail(event, emit));
    on<LoginWithPhoneNumber>(
        (event, emit) => _onLoginWithPhoneNumber(event, emit));

    on<GoogleSingInPressed>((event, emit) async {
      await _googleSignButtonPressed(emit);
    });
  }

  Future<void> _onLoginWithEmail(
      LoginWithEmail event, Emitter<LoginState> emit) async {
    String result =
        await AuthenticationData().login(event.email, event.password);
    if (result == 'Success') {
      emit(LoginState(loginStatus: LoginStatus.success, result: result));
    } else {
      emit(LoginState(loginStatus: LoginStatus.failure, result: result));
    }
  }

  Future<void> _onLoginWithPhoneNumber(
      LoginWithPhoneNumber event, Emitter<LoginState> emit) async {
    //TODO
    log('IS a printed', name: 'LoginBloc _onLoginWithPhoneNumber');
    emit(const LoginState(loginStatus: LoginStatus.success, result: 'Success'));
  }

  Future<void> _googleSignButtonPressed(Emitter<LoginState> emit) async {
    emit(const LoginState().copyWith(loginStatus: LoginStatus.loading));
    String result = await AuthenticationData().signInWithGoogle();

    if (result == 'Success' || result.contains('@')) {
      // TODO
      emit(LoginState(loginStatus: LoginStatus.success, result: result));
    } else {
      emit(LoginState(loginStatus: LoginStatus.failure, result: result));
    }
  }

  Future<void> _loginButtonPressed(
      Emitter<LoginState> emit, LoginButtonPressed event) async {
    emit(LoginState(
        loginStatus: LoginStatus.loading, loginType: state.loginType));
    log(state.loginType.toString(), name: 'State loginType');
    if (state.loginType == LoginType.email) {
      add(LoginWithEmail(email: event.email, password: event.password));
    } else {
      add(LoginWithPhoneNumber(email: event.email, password: event.password));
    }
  }

  Future<void> _onChangeLoginType(
      ChangeLoginType event, Emitter<LoginState> emit) async {
    if (state.loginType == LoginType.email) {
      emit(const LoginState(
          loginType: LoginType.phone,
          loginStatus: LoginStatus.initial,
          result: ''));
    } else {
      emit(const LoginState(
          loginType: LoginType.email,
          loginStatus: LoginStatus.initial,
          result: ''));
    }
  }
}
