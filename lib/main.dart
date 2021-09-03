import 'package:f_set/data/game_cubit.dart';
import 'package:f_set/presentation/set_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(Phoenix(
    child: SetApp(),
  ));
}

class SetApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
      create: (context) => GameCubit()..initialize(),
      child: MaterialApp(
        home: BlocProvider<GameCubit>(
          create: (context) => GameCubit()..initialize(),
          child: Game(),
        ),
      ),
    );
  }
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          child: Builder(
            builder: (context) {
              return SetBoard();
            },
          ),
        ),
      ),
    );
  }
}
