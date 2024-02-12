part of 'sign_bloc.dart';

enum SignStatus { initial, loading, success, failure }

enum SignType { email, phoneNumber }

class SignState extends Equatable {
  final SignStatus signStatus;
  final String result;
  final SignType signType;

  const SignState(
      {this.signStatus = SignStatus.initial,
      this.result = '',
      this.signType = SignType.email});

  SignState copyWith(
      {SignStatus? signStatus, String? result, SignType? signType}) {
    return SignState(
        signStatus: signStatus = signStatus ?? this.signStatus,
        result: result = result ?? this.result,
        signType: signType = signType ?? this.signType);
  }

  @override
  List<Object> get props => [signStatus, result, signType];
}
