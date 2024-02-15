import 'package:auth/auth/data/authentication_data.dart';
import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/data/validator.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(const SignState(signStatus: SignStatus.initial)) {
    on<SignButtonPressed>(
        (event, emit) async => await _onSignButtonPressed(emit, event));
  }

  Future<void> _onSignButtonPressed(
      Emitter<SignState> emit, SignButtonPressed event) async {
    emit(const SignState(signStatus: SignStatus.loading));
    // Что тут происходит?
    MyUser createMyUser = MyUser(
        userId: 'xxx', // TODO check
        email: event.email,
        phoneNumber: Validator().clearPhoneNumber(event.phoneNumber),
        name: event.userName);

    try {
      MyUser myUserFromFirebase = await AuthenticationData().signUp(
          createMyUser, event.password); // Тут я регистрирую пользователя
      try {
        await FirebaseUserSettings().createUser(
            myUserFromFirebase); // Тут проиходит создание документа пользователя в Firestore Firebase
        emit(const SignState(signStatus: SignStatus.success, result: ''));
      } catch (error) {
        emit(SignState(
            signStatus: SignStatus.failure, result: error.toString()));
      }
    } catch (error) {
      emit(SignState(signStatus: SignStatus.failure, result: error.toString()));
    }
  }
}
