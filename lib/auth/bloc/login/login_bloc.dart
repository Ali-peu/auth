import 'package:auth/auth/data/authentication_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(loginStatus: LoginStatus.initial, result: '')) {
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoginState(loginStatus: LoginStatus.loading));
      String result =
          await AuthenticationData().login(event.email, event.password);
      if (result == 'Success') {
        // Указание на эту проблему в authentithication_data.dart
        emit(LoginState(loginStatus: LoginStatus.success, result: result));
      } else {
        emit(LoginState(loginStatus: LoginStatus.failure, result: result));
      }
    });

    on<GoogleSingInPressed>((event, emit) async {
      emit(const LoginState().copyWith(loginStatus: LoginStatus.loading));
      String result = await AuthenticationData().signInWithGoogle();

      if (result == 'Success') {
        // Указание на эту проблему в authentithication_data.dart
        emit(LoginState(loginStatus: LoginStatus.success, result: result));
      } else {
        emit(LoginState(loginStatus: LoginStatus.failure, result: result));
      }
    });
  }
}
