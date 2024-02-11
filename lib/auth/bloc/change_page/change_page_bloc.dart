import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_page_event.dart';
part 'change_page_state.dart';

class ChangePageBloc extends Bloc<ChangePageEvent, ChangePageState> {
  ChangePageBloc()
      : super(const ChangePageState(pageStatus: PageStatus.firstPage)) {
    on<ChangePagePressedEvent>((event, emit) {
      if (state.pageStatus == PageStatus.firstPage) {
        emit(const ChangePageState(pageStatus: PageStatus.secondPage));
      } else {
        emit(const ChangePageState(pageStatus: PageStatus.firstPage));
      }
    });
  }
}
