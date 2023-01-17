part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}


class TodoFetch extends TodoEvent {
  const TodoFetch();
}

class TodoRefresh extends TodoEvent {
  const TodoRefresh();
}