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

class SignWithEmail extends SignButtonPressed {
  const SignWithEmail({required super.password, required super.signEmail});
}

class SignWithPhoneNumber extends SignButtonPressed {
  const SignWithPhoneNumber(
      {required super.password, required super.signEmail});
}

class FillUserData extends SignEvent {
  final String userSignEmail;
  final String updateName;

  const FillUserData({required this.userSignEmail, required this.updateName});
}

class FillUserDataWhoSignWithEmail extends FillUserData {
  const FillUserDataWhoSignWithEmail(
      {required super.userSignEmail, required super.updateName});
}

class FillUserDataWhoSignWithPhoneNumber extends FillUserData {
  const FillUserDataWhoSignWithPhoneNumber(
      {required super.userSignEmail, required super.updateName});
}

class GoogleSingInPressed extends SignEvent {}

class ChangeSignType extends SignEvent {}
