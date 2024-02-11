part of 'change_page_bloc.dart';

@immutable
sealed class ChangePageEvent {}

class ChangePagePressedEvent extends ChangePageEvent {}

