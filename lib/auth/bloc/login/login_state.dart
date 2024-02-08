part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String result;

  const LoginState({this.loginStatus = LoginStatus.initial, this.result = ''});

  LoginState copyWith({LoginStatus? loginStatus, String? result}) {
    return LoginState(
        loginStatus: loginStatus = loginStatus ?? this.loginStatus,
        result: result = result ?? this.result);
  }

  @override
  List<Object> get props => [loginStatus, result];
}
