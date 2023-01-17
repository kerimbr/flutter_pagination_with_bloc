import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:flutter_pagination_with_bloc/blocs/todo_bloc/enum/todo_status.dart';
import 'package:flutter_pagination_with_bloc/models/todo/todo_model.dart';
import 'package:flutter_pagination_with_bloc/service/todo_service/todo_service.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    // Initial Event
    on<TodoFetch>(
      _onTodoFetch,
      transformer: droppable(),
    );

    // Refresh Event
    on<TodoRefresh>(
      _onTodoRefresh,
      transformer: droppable(),
    );
  }

  final TodoService _todoService = TodoService.instance;

  FutureOr<void> _onTodoFetch(TodoFetch event, Emitter<TodoState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == TodoStatus.initial) {
        final todos = await _todoService.fetchTodos();
        return emit(
          state.copyWith(
            todos: todos,
            hasReachedMax: false,
            status: TodoStatus.success,
          ),
        );
      }

      final todos = await _todoService.fetchTodos(state.todos.length);
      if (todos.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(
          state.copyWith(
            todos: List.of(state.todos)..addAll(todos),
            hasReachedMax: false,
          ),
        );
      }
    } catch (e) {
      debugPrint("[HATA] [TodoBloc] [_onTodoFetch] --> $e");
      return emit(state.copyWith(status: TodoStatus.error));
    }
  }

  FutureOr<void> _onTodoRefresh(TodoRefresh event, Emitter<TodoState> emit) async {
    emit(const TodoState());
    await Future.delayed(const Duration(seconds: 1));
    add(const TodoFetch());
  }

}
