part of 'sign_or_login_bloc.dart';

enum PageStatus { login, sign }

class SignOrLoginState extends Equatable {
  final PageStatus pageStatus;
  const SignOrLoginState({required this.pageStatus});
  @override
  
  List<Object?> get props => [pageStatus];
}
