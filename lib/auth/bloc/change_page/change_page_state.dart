part of 'change_page_bloc.dart';

enum PageStatus { firstPage, secondPage }

class ChangePageState extends Equatable {
  final PageStatus pageStatus;
  const ChangePageState({required this.pageStatus});
  @override
  List<Object?> get props => [pageStatus];
}
