part of 'sign_bloc.dart';

sealed class SignEvent extends Equatable {
  const SignEvent();

  @override
  List<Object> get props => [];
}

class SignButtonPressed extends SignEvent {
  final String password;
  final String signEmail;

  const SignButtonPressed({required this.password, required this.signEmail});
}

class SignWithEmail extends SignEvent {
  final String password;
  final String signEmail;
  const SignWithEmail({required this.password, required this.signEmail});
}

class SignWithPhoneNumber extends SignEvent {
  // TODO ПОчинить у LoginSEvent
  final String password;
  final String signEmail;
  const SignWithPhoneNumber({required this.password, required this.signEmail});
}

class FillUserData extends SignEvent {
  final String userSignEmail;
  final String updateName;

  const FillUserData({required this.userSignEmail, required this.updateName});
}

class FillUserDataWhoSignWithEmail extends SignEvent {
  final String userSignEmail;
  final String updateName;
  const FillUserDataWhoSignWithEmail(
      {required this.userSignEmail, required this.updateName});
}

class FillUserDataWhoSignWithPhoneNumber extends SignEvent {
  final String userSignEmail;
  final String updateName;
  const FillUserDataWhoSignWithPhoneNumber(
      {required this.userSignEmail, required this.updateName});
}

class GoogleSingInPressed extends SignEvent {}

class ChangeSignType extends SignEvent {}
