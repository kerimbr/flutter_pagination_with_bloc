import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination_with_bloc/blocs/observers/todo_bloc_observer.dart';
import 'package:flutter_pagination_with_bloc/view/home_page.dart';

void main() {
  Bloc.observer = TodoBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple
      ),
      home: const HomePage(),
    );
  }
}
