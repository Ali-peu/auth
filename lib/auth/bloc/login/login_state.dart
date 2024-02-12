part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

enum LoginType { phone, email }

class LoginState extends Equatable {
  final LoginStatus loginStatus;
  final String result;
  final LoginType loginType;
  final bool newUser;

  const LoginState(
      {this.loginStatus = LoginStatus.initial,
      this.result = '',
      this.loginType = LoginType.email,
      this.newUser = false});

  LoginState copyWith(
      {LoginStatus? loginStatus,
      String? result,
      LoginType? loginType,
      bool? newUser}) {
    return LoginState(
        loginStatus: loginStatus = loginStatus ?? this.loginStatus,
        result: result = result ?? this.result,
        loginType: loginType = loginType ?? this.loginType,
        newUser: newUser = newUser ?? this.newUser);
  }

  @override
  List<Object> get props => [loginStatus, result, loginType,newUser];
}
