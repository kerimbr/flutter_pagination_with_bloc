import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class TodoBlocObserver extends BlocObserver{

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint("[BLOC OBX] [${bloc.runtimeType}] [${transition.currentState.runtimeType}] --> [${transition.nextState.runtimeType}]");
    super.onTransition(bloc, transition);
  }

}