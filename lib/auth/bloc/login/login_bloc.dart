import 'dart:developer';

import 'package:auth/auth/data/authentication_data.dart';
import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginButtonPressed>(
        (event, emit) async => await _loginButtonPressed(emit, event));
    on<CheckThisIsNewUser>(
        (event, emit) async => await _checkThisIsNewUser(emit));

    on<ChangeLoginType>((event, emit) => _onChangeLoginType(event, emit));
    on<LoginWithEmail>((event, emit) => _onLoginWithEmail(event, emit));
    on<LoginWithPhoneNumber>(
        (event, emit) => _onLoginWithPhoneNumber(event, emit));

    on<GoogleSingInPressed>((event, emit) async {
      await _googleSignButtonPressed(emit);
    });
  }

  Future<void> _checkThisIsNewUser(Emitter<LoginState> emit) async {
    var currentUserEmail = '';
    try {
      final docSnapshot = await FirebaseUserSettings().getUserInfo();
      currentUserEmail = docSnapshot['email'] as String;
      emit(const LoginState(
          loginStatus: LoginStatus.success, result: 'Success'));
    } on Exception catch (error) {
      log(error.toString(), name: 'Errors _checkThisIsNewUser from LoginBloc');
      emit(LoginState(
          loginStatus: LoginStatus.success,
          result: currentUserEmail,
          newUser: true));
    }
  }

  Future<void> _onLoginWithEmail(
      LoginWithEmail event, Emitter<LoginState> emit) async {
    emit(const LoginState(loginStatus: LoginStatus.loading));

    try {
      await AuthenticationData().login(event.email, event.password);
      emit(const LoginState(loginStatus: LoginStatus.success));
    } catch (error) {
      emit(LoginState(
          loginStatus: LoginStatus.failure, result: error.toString()));
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

    try {
      await AuthenticationData().signInWithGoogle();
      emit(const LoginState(loginStatus: LoginStatus.success));
    } catch (error) {
      emit(LoginState(
          loginStatus: LoginStatus.failure,
          result: error
              .toString())); // TODO Нужен toast для уведомдение пользователя
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
      emit(const LoginState(loginType: LoginType.phone));
    } else {
      emit(const LoginState());
    }
  }
}
