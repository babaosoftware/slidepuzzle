import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/hint.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(this.boardType, this.boardSize) : super(GameState(boardType, boardSize)) {
    on<InitializeGame>(_onInitializeGame);
    on<NewGame>(_onNewGame);
    on<TileClick>(_onTileClick);
    on<RestartGame>(_onRestartGame);
    on<AutoPlay>(_onAutoPlay);
    on<GameHint>(_onGameHint);
    on<GameHintReceived>(_onGameHintReceived);
    on<GameBack>(_onGameBack);
  }

  final BoardType boardType;
  final int boardSize;
  List<int> values = [];

  void _onInitializeGame(InitializeGame event, Emitter<GameState> emit) {
    if (!state.initialized) {
      Game newGame = Game(boardType, boardSize);
      values = [];
      emit(state.copyWith(
        game: newGame,
        startGame: Game.copy(newGame),
        boardState: BoardState.start,
        hintStack: [],
        prevBoard: Board.copy(state.game.getGameBoard()),
        currentBoard: Board.copy(newGame.getGameBoard()),
        counter: 0,
        initialized: true,
      ));
    }
  }

  void _onNewGame(NewGame event, Emitter<GameState> emit) {
    Game newGame = Game(boardType, boardSize);
    values = [];
    emit(state.copyWith(
      game: newGame,
      startGame: Game.copy(newGame),
      boardState: BoardState.start,
      hintStack: [],
      prevBoard: Board.copy(state.game.getGameBoard()),
      currentBoard: Board.copy(newGame.getGameBoard()),
      counter: 0,
    ));
  }

  void _onTileClick(TileClick event, Emitter<GameState> emit) {
    if (state.game.moveValue(event.value)) {
      values = [];
      emit(state.copyWith(
        game: Game.copy(state.game),
        boardState: state.game.checkGameSolved() ? BoardState.end : BoardState.ongoing,
        hintStack: [],
        prevBoard: Board.copy(state.currentBoard),
        currentBoard: Board.copy(state.game.getGameBoard()),
        counter: state.counter + 1,
      ));
    }
  }

  void _onGameBack(GameBack event, Emitter<GameState> emit) {
    Game backGame = Game.copy(state.game);
    backGame.moveBack();
    int newCounter = state.counter - 1;
    values = [];
    emit(state.copyWith(
      game: backGame,
      boardState: newCounter <= 0 ? BoardState.start : BoardState.ongoing,
      hintStack: [],
      prevBoard: Board.copy(state.game.getGameBoard()),
      currentBoard: Board.copy(backGame.getGameBoard()),
      counter: newCounter,
    ));
  }

  void _onRestartGame(RestartGame event, Emitter<GameState> emit) {
    values = [];
    emit(state.copyWith(
      game: Game.copy(state.startGame),
      boardState: BoardState.start,
      hintStack: [],
      prevBoard: Board.copy(state.game.getGameBoard()),
      currentBoard: Board.copy(state.startGame.getGameBoard()),
      counter: 0,
    ));
  }

  void _onGameHintReceived(GameHintReceived event, Emitter<GameState> emit) {
    Board savedBoard = Board.copy(state.game.gameBoard);
    if (event.value != 0 && state.game.moveValue(event.value)) {
      bool gameSolved = state.game.checkGameSolved();
      if (state.autoPlay) state.hintStack.add(savedBoard);
      emit(state.copyWith(
        game: Game.copy(state.game),
        autoPlay: gameSolved ? false : state.autoPlay,
        boardState: gameSolved ? BoardState.end : BoardState.ongoing,
        hintStack: state.autoPlay ? state.hintStack : [],
        prevBoard: Board.copy(state.currentBoard),
        currentBoard: Board.copy(state.game.getGameBoard()),
        counter: state.counter + 1,
      ));
    }
  }

  void _gameHint(bool fromAutoPlay) {
    Timer(Duration(milliseconds: fromAutoPlay ? 500 : 100), () async {
      if (isClosed || fromAutoPlay && !state.autoPlay) return;
      int value;
      if (values.isNotEmpty) {
        value = values.removeLast();
      } else {
        Hint hint = await calculateNextMove(Game.copy(state.game), state.hintStack);
        values = hint.values;
        value = values.isEmpty ? 0 : values.removeLast();
      }
      if (isClosed || fromAutoPlay && !state.autoPlay) return;
      add(GameHintReceived(value));
      if (fromAutoPlay) {
        _gameHint(true);
      }
    });
  }

  void _onGameHint(GameHint event, Emitter<GameState> emit) {
    emit(state.copyWith(boardState: BoardState.hint, prevBoard: Board.copy(state.currentBoard), hintStack: []));
    _gameHint(false);
  }

  void _onAutoPlay(AutoPlay event, Emitter<GameState> emit) {
    emit(state.copyWith(autoPlay: !state.autoPlay, boardState: BoardState.ongoing, prevBoard: Board.copy(state.currentBoard), hintStack: []));
    _gameHint(true);
  }

  Future<Hint> calculateNextMove(Game game, List<Board> hintStack) {
    return compute(calculateMove, CalculateMoveParams(game, hintStack));
  }
}

class CalculateMoveParams {
  final Game game;
  final List<Board> hintStack;

  CalculateMoveParams(this.game, this.hintStack);
}

Hint calculateMove(CalculateMoveParams params) {
  return params.game.getBoardHint(params.hintStack);
}
