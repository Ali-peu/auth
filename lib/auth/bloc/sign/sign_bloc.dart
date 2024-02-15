import 'dart:developer';

import 'package:auth/auth/data/another_servise_user_settings.dart';
import 'package:auth/auth/data/authentication_data.dart';
import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc() : super(const SignState()) {
    on<SignButtonPressed>((event, emit) => _signButtonPressed(emit, event));

    on<SignWithEmail>(_signWithEmail);
    on<SignWithPhoneNumber>(_signWithPhoneNumber);

    on<GoogleSingInPressed>(_onGoogleSignInPressed);
    on<ChangeSignType>(_onChangeSignType);

    on<FillUserDataWhoSignWithEmail>(_fillUserDataWhoSignWithEmail);

    on<FillUserDataWhoSignWithPhoneNumber>(
        (event, emit) => _fillUserDataWhoSignWithPhoneNumber(emit)); // TODO

    on<FillUserData>((event, emit) async {
      _fiilUserData(event);
    });
  }

  Future<void> _fillUserDataWhoSignWithPhoneNumber(
      Emitter<SignState> emit) async {
    try {
      await AnotherPhoneServiseUserSettings()
          .updateUserSettingsInAnotherService();
      emit(const SignState(signStatus: SignStatus.success, result: 'Success'));
    } on Exception catch (error) {
      log(error.toString(), name: 'Error on Firebase user document update: ');
      emit(const SignState(signStatus: SignStatus.failure, result: 'Failure'));
      // TODO
    }
  }

  Future<void> _fillUserDataWhoSignWithEmail(
      FillUserDataWhoSignWithEmail event, Emitter<SignState> emit) async {
    try {
      await FirebaseUserSettings()
          .updateFirebaseUserDocument(event.userSignEmail, event.updateName);
      emit(const SignState(signStatus: SignStatus.success, result: 'Success'));
    } on Exception catch (error) {
      log(error.toString(), name: 'Error on Firebase user document update: ');
      emit(const SignState(signStatus: SignStatus.failure, result: 'Failure'));
    }
  }

  void _fiilUserData(FillUserData event) {
    if (event.userSignEmail.contains('@')) {
      add(FillUserDataWhoSignWithEmail(
          userSignEmail: event.userSignEmail, updateName: event.updateName));
    } else {
      add(FillUserDataWhoSignWithPhoneNumber(
          userSignEmail: event.userSignEmail, updateName: event.updateName));
    }
  }

  Future<void> _signWithPhoneNumber(
      // TODO sign with phone number
      SignWithPhoneNumber event,
      Emitter<SignState> emit) async {
    bool signWithPhoneNumberResult =
        await AuthenticationData().signWithPhoneNumber();
    if (signWithPhoneNumberResult) {
      emit(const SignState(signStatus: SignStatus.success, result: 'Success'));
    } else {
      emit(const SignState(signStatus: SignStatus.failure, result: 'Failure'));
    }
  }

  Future<void> _signWithEmail(
      SignWithEmail event, Emitter<SignState> emit) async {
    emit(const SignState(signStatus: SignStatus.loading));
    // Что тут происходит?
    MyUser createMyUser = MyUser(
        userId: 'xxx', email: event.signEmail, phoneNumber: '', name: '');
    try {
      MyUser myUserFromFirebase = await AuthenticationData().signUp(
          createMyUser, event.password); // Тут я регистрирую пользователя
      try {
        await FirebaseUserSettings().createUser(
            myUserFromFirebase); // Тут проиходит создание документа пользователя в Firestore Firebase
        emit(const SignState(signStatus: SignStatus.success));
      } catch (error) {
        emit(SignState(
            signStatus: SignStatus.failure, result: error.toString()));
      }
    } catch (error) {
      emit(SignState(signStatus: SignStatus.failure, result: error.toString()));
    }
  }

  Future<void> _signButtonPressed(
      // Это метод используется в самом регистрации пользователя только email and password или password
      // Пока не понимаю и не помню для чего ээто был содан
      Emitter<SignState> emit,
      SignButtonPressed event) async {
    emit(const SignState(signStatus: SignStatus.loading));
    if (state.signType == SignType.email) {
      add(SignWithEmail(password: event.password, signEmail: event.signEmail));
    } else {
      add(SignWithPhoneNumber(
          password: event.password, signEmail: event.signEmail));
    }
  }

  Future<void> _onChangeSignType(
      ChangeSignType event, Emitter<SignState> emit) async {
    if (state.signType == SignType.email) {
      emit(const SignState(signType: SignType.phoneNumber));
    } else {
      emit(const SignState());
    }
  }

  Future<void> _onGoogleSignInPressed(
      GoogleSingInPressed event, Emitter<SignState> emit) async {
    emit(const SignState().copyWith(signStatus: SignStatus.loading));
    try {
      await AuthenticationData().signInWithGoogle();
      emit(const SignState(signStatus: SignStatus.success));
    } catch (error) {
      emit(SignState(signStatus: SignStatus.failure, result: error.toString()));
    }
  }
}
