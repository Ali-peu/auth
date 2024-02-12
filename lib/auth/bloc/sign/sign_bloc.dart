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
  SignBloc() : super(const SignState(signStatus: SignStatus.initial)) {
    on<SignButtonPressed>(
        (event, emit) async => await _signButtonPressed(emit, event));

    on<SignWithEmail>((event, emit) async => await _signWithEmail(event, emit));
    on<SignWithPhoneNumber>(
        (event, emit) async => await _signWithPhoneNumber(event, emit));

    on<GoogleSingInPressed>(
        (event, emit) => _onGoogleSignInPressed(event, emit));
    on<ChangeSignType>((event, emit) => _onChangeSignType(event, emit));

    on<FillUserDataWhoSignWithEmail>((event, emit) async =>
        await _fillUserDataWhoSignWithEmail(event, emit));

    on<FillUserDataWhoSignWithPhoneNumber>((event, emit) async =>
        await _fillUserDataWhoSignWithPhoneNumber(emit)); // TODO

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
    MyUser createMyUser = MyUser.empty;
    createMyUser = MyUser(
        userId: 'false', // TODO check
        email: event.signEmail,
        phoneNumber: 'no',
        name: 'no');

    MyUser myUserFromFirebase =
        await AuthenticationData().signUp(createMyUser, event.password);
    log(myUserFromFirebase.email, name: 'SignBLOC _signWithEmail email:');
    log(myUserFromFirebase.userId, name: 'SignBLOC _signWithEmail userId:');
    log(myUserFromFirebase.phoneNumber, name: 'SignBLOC _signWithEmail phoneNumber:');
    log(myUserFromFirebase.name, name: 'SignBLOC _signWithEmail name:');

    String result = await FirebaseUserSettings().createUser(myUserFromFirebase);
    if (myUserFromFirebase.userId == 'false') {
      // String result =
      //     await FirebaseUserSettings().createUser(myUserFromFirebase);
      log(result, name: 'FirebaseUserSettings createUser:');
      if (result == 'Success') {
        emit(SignState(signStatus: SignStatus.success, result: result));
      } else {
        emit(SignState(signStatus: SignStatus.success, result: result));
      }
    } else {
      emit(SignState(
          signStatus: SignStatus.failure, result: myUserFromFirebase.name));
    }
  }

  Future<void> _signButtonPressed(
      Emitter<SignState> emit, SignButtonPressed event) async {
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
    log(state.signType.toString(), name: 'State signType ');
    if (state.signType == SignType.email) {
      emit(const SignState(
          signType: SignType.phoneNumber,
          signStatus: SignStatus.initial,
          result: ''));
    } else {
      emit(const SignState(
          signType: SignType.email,
          signStatus: SignStatus.initial,
          result: ''));
    }
    log(state.signType.toString(), name: 'State signType 2');

    log(state.signType.toString(), name: 'State signType 3');
  }

  Future<void> _onGoogleSignInPressed(
      GoogleSingInPressed event, Emitter<SignState> emit) async {
    emit(const SignState().copyWith(signStatus: SignStatus.loading));
    String result = await AuthenticationData().signInWithGoogle();

    if (result == 'Success') {
      emit(SignState(signStatus: SignStatus.success, result: result));
    } else {
      emit(SignState(signStatus: SignStatus.failure, result: result));
    }
  }
}
