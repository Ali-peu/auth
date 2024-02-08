part of 'sign_bloc.dart';

enum SignStatus { initial, loading, success, failure }

class SignState extends Equatable {
  final SignStatus signStatus;
  final String result;

  const SignState({this.signStatus = SignStatus.initial, this.result = ''});

  SignState copyWith({SignStatus? loginStatus, String? result}) {
    return SignState(
        signStatus: loginStatus = loginStatus ?? this.signStatus,
        result: result = result ?? this.result);
  }

  @override
  List<Object> get props => [signStatus, result];
}
