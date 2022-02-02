import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/models/cell.dart';

class AutoPlayCubit extends Cubit<bool> {
  AutoPlayCubit() : super(false);
  void flip() => emit(!state);
  void start() => emit(true);
  void stop() => emit(false);
}

class NewGameCubit extends Cubit<bool> {
  NewGameCubit() : super(true);
  void newGame() => emit(!state);
}

class RestartGameCubit extends Cubit<bool> {
  RestartGameCubit() : super(true);
  void restartGame() => emit(!state);
}

class TileClickCubit extends Cubit<int> {
  TileClickCubit() : super(-1);
  void tileClick(value) {
    emit(value);
    Timer(const Duration(milliseconds: 20), () {
      emit(-1);
    });
  }
}

class HintCubit extends Cubit<bool> {
  HintCubit() : super(true);
  void hint() => emit(!state);
}

class GameCounterCubit extends Cubit<int> {
  GameCounterCubit() : super(0);
  void stepUp() => emit(state + 1);
  void stepDown() => emit(state - 1);
  void reset() => emit(0);
}
