import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/models/cell.dart';

class AutoPlayCubit extends Cubit<bool> {
  AutoPlayCubit() : super(false);
  void flip() => emit(!state);
  void start() => emit(true);
  void stop() => emit(false);
}

final autoPlayCubit = AutoPlayCubit();

class NewGameCubit extends Cubit<bool> {
  NewGameCubit() : super(true);
  void newGame() => emit(!state);
}

final newGameCubit = NewGameCubit();

class RestartGameCubit extends Cubit<bool> {
  RestartGameCubit() : super(true);
  void restartGame() => emit(!state);
}

final restartGameCubit = RestartGameCubit();

class TileClickCubit extends Cubit<int> {
  TileClickCubit() : super(-1);
  void tileClick(value) {
    emit(value);
    Timer(const Duration(milliseconds: 20), () {
      emit(-1);
    });
  }
}

final tileClickCubit = TileClickCubit();
