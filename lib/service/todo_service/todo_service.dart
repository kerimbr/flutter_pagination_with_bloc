import 'package:dio/dio.dart';
import 'package:flutter_pagination_with_bloc/core/constants/service_constants.dart';
import 'package:flutter_pagination_with_bloc/models/todo/todo_model.dart';

class TodoService {

  static final TodoService _instance = TodoService._init();
  static TodoService get instance => _instance;
  TodoService._init();

  final _constants = ServiceConstants.instance;
  final Dio _dio = Dio();

  Future<List<TodoModel>> fetchTodos([int start = 0]) async {

    String url = '${_constants.baseUrl}${_constants.todosPath}?${_constants.startQuery}=$start&${_constants.limitQuery}=${_constants.limitValue}';

    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => TodoModel.fromJson(e)).cast<TodoModel>().toList();
    } else {
      throw Exception('Failed to load todos');
    }

  }

}