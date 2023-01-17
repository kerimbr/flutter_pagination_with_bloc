import 'package:flutter/material.dart';
import 'package:flutter_pagination_with_bloc/blocs/todo_bloc/enum/todo_status.dart';
import 'package:flutter_pagination_with_bloc/blocs/todo_bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination_with_bloc/view/widgets/home_error_view.dart';
import 'package:flutter_pagination_with_bloc/widgets/progress_indicators/custom_circular_progress_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (_) => TodoBloc()..add(const TodoFetch()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      context.read<TodoBloc>().add(const TodoFetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == TodoStatus.success) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TodoBloc>().add(const TodoRefresh());
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax ? state.todos.length : state.todos.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.todos.length
                      ? const Center(
                          child: CustomCircularProgressIndicator(),
                        )
                      : buildTodo(context, state, index);
                },
              ),
            );
          } else {
            return const HomeErrorView();
          }
        },
      ),
    );
  }

  ListTile buildTodo(BuildContext context, TodoState state, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Text(
          '${state.todos[index].id}',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
          state.todos[index].title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w300,
          ),
      ),
      trailing: state.todos[index].completed ? const Icon(Icons.check, color: Colors.green) : const Icon(Icons.close, color: Colors.red),
    );
  }
}
