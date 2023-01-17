part of 'todo_bloc.dart';

class TodoState extends Equatable{

  final List<TodoModel> todos;
  final bool hasReachedMax;
  final TodoStatus status;

  const TodoState({
    this.todos = const <TodoModel>[],
    this.hasReachedMax = false,
    this.status = TodoStatus.initial
  });


  TodoState copyWith({
    List<TodoModel>? todos,
    bool? hasReachedMax,
    TodoStatus? status,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [todos, hasReachedMax, status];
}