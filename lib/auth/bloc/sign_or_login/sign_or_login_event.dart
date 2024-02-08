part of 'sign_or_login_bloc.dart';

@immutable
sealed class SignOrLoginEvent {}

class ChangePageEvent extends SignOrLoginEvent {}
