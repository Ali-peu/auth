part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  const LoginButtonPressed({required this.email, required this.password});
}

class LoginWithEmail extends LoginButtonPressed {
  const LoginWithEmail({required super.email, required super.password});
}

class LoginWithPhoneNumber extends LoginButtonPressed {
  const LoginWithPhoneNumber({required super.email, required super.password});
}

class GoogleSingInPressed extends LoginEvent {}

class ChangeLoginType extends LoginEvent {}
