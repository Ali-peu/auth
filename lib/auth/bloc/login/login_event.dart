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

class LoginWithEmail extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmail({required this.email, required this.password});
}

class LoginWithPhoneNumber extends LoginEvent {
  final String email;
  final String password;

  const LoginWithPhoneNumber({required this.email, required this.password});
}

class GoogleSingInPressed extends LoginEvent {}

class ChangeLoginType extends LoginEvent {}


class CheckThisIsNewUser extends LoginEvent{
  
}