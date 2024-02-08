part of 'sign_bloc.dart';

sealed class SignEvent extends Equatable {
  const SignEvent();

  @override
  List<Object> get props => [];
}

class SignButtonPressed extends SignEvent {
  final String userName;
  final String phoneNumber;
  final String password;
  final String email;

  const SignButtonPressed(
      {required this.userName,
      required this.phoneNumber,
      required this.password,
      required this.email});
}
