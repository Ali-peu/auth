import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sign_or_login_event.dart';
part 'sign_or_login_state.dart';

class SignOrLoginBloc extends Bloc<SignOrLoginEvent, SignOrLoginState> {
  SignOrLoginBloc() : super(SignOrLoginState(pageStatus: PageStatus.login)) {
    on<ChangePageEvent>((event, emit) {
      if (state.pageStatus == PageStatus.login) {
        emit(SignOrLoginState(pageStatus: PageStatus.sign));
      } else {
        emit(SignOrLoginState(pageStatus: PageStatus.login));
      }
    });
  }
}
