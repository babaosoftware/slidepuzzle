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
  GameBloc(this.boardType, this.boardSize, {bool isArena = false}) : super(GameState(boardType, boardSize, isArena: isArena)) {
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

  void _onInitializeGame(InitializeGame event, Emitter<GameState> emit) {
    if (!state.initialized) {
      Game newGame = Game(boardType, boardSize);
      if (state.isArena) {
        Game newGameComputer = Game.copy(newGame);
        emit(state.copyWith(
          game: newGame,
          gameComputer: newGameComputer,
          startGame: Game.copy(newGame),
          boardState: BoardState.start,
          hintStack: [],
          hintStackComputer: [],
          prevBoard: Board.copy(state.game.getGameBoard()),
          prevBoardComputer: Board.copy(state.game.getGameBoard()),
          currentBoard: Board.copy(newGame.getGameBoard()),
          currentBoardComputer: Board.copy(newGameComputer.getGameBoard()),
          counter: 0,
          initialized: true,
        ));
      } else {
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
  }

  void _onNewGame(NewGame event, Emitter<GameState> emit) {
    Game newGame = Game(boardType, boardSize);
    if (state.isArena) {
      Game newGameComputer = Game.copy(newGame);
      emit(state.copyWith(
        game: newGame,
        gameComputer: newGameComputer,
        startGame: Game.copy(newGame),
        boardState: BoardState.start,
        hintStack: [],
        hintStackComputer: [],
        prevBoard: Board.copy(state.game.getGameBoard()),
        prevBoardComputer: Board.copy(state.game.getGameBoard()),
        currentBoard: Board.copy(newGame.getGameBoard()),
        currentBoardComputer: Board.copy(newGameComputer.getGameBoard()),
        counter: 0,
        initialized: true,
      ));
    } else {
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
  }

  void _onTileClick(TileClick event, Emitter<GameState> emit) {
    if (state.game.moveValue(event.value)) {
      emit(state.copyWith(
        game: Game.copy(state.game),
        boardState: state.game.checkGameSolved() ? BoardState.end : BoardState.ongoing,
        hintStack: [],
        prevBoard: Board.copy(state.currentBoard),
        prevBoardComputer: Board.copy(state.currentBoardComputer),
        currentBoard: Board.copy(state.game.getGameBoard()),
        counter: state.counter + 1,
      ));
      if (state.isArena) _gameHint(false);
    }
  }

  void _onGameBack(GameBack event, Emitter<GameState> emit) {
    Game backGame = Game.copy(state.game);
    backGame.moveBack();
    int newCounter = state.counter - 1;
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
    if (state.isArena) {
      if (state.gameComputer.moveValue(event.value)) {
        bool gameSolved = state.game.checkGameSolved() || state.gameComputer.checkGameSolved();
        emit(state.copyWith(
          boardState: gameSolved ? BoardState.end : BoardState.ongoing,
          prevBoard: Board.copy(state.currentBoard),
          prevBoardComputer: Board.copy(state.currentBoardComputer),
          currentBoardComputer: Board.copy(state.gameComputer.getGameBoard()),
        ));
      }
    } else {
      if (state.game.moveValue(event.value)) {
        bool gameSolved = state.game.checkGameSolved();
        state.hintStack.add(Board.copy(state.game.getGameBoard()));
        emit(state.copyWith(
          game: Game.copy(state.game),
          autoPlay: gameSolved ? false : state.autoPlay,
          boardState: gameSolved ? BoardState.end : BoardState.ongoing,
          prevBoard: Board.copy(state.currentBoard),
          currentBoard: Board.copy(state.game.getGameBoard()),
          counter: state.counter + 1,
        ));
      }
    }
  }

  void _gameHint(bool fromAutoPlay) {
    Timer(const Duration(milliseconds: 400), () async {
      Hint hint = await calculateNextMove(Game.copy(state.isArena ? state.gameComputer : state.game), state.hintStack);
      if (isClosed || fromAutoPlay && !state.autoPlay) return;
      add(GameHintReceived(hint.value));
      if (fromAutoPlay) {
        _gameHint(true);
      }
      // }
    });
  }

  void _onGameHint(GameHint event, Emitter<GameState> emit) {
    emit(state.copyWith(boardState: BoardState.hint, prevBoard: Board.copy(state.currentBoard)));
    _gameHint(false);
  }

  void _onAutoPlay(AutoPlay event, Emitter<GameState> emit) {
    emit(state.copyWith(autoPlay: !state.autoPlay, boardState: BoardState.ongoing, prevBoard: Board.copy(state.currentBoard)));
    _gameHint(true);
    // emit(state.copyWith(
    //     game: Game.copy(state.startGame),
    //     boardState: BoardState.start,
    //     hintStack: [],
    //     prevBoard: Board.copy(state.game.getGameBoard()),
    //     currentBoard: Board.copy(state.startGame.getGameBoard())));
  }

  Future<Hint> calculateNextMove(Game game, List<Board> hintStack) {
    return compute(calculateMove, CalculateMoveParam(game, hintStack));
  }

// emit was called after an event handler completed normally.
// This is usually due to an unawaited future in an event handler.
// Please make sure to await all asynchronous operations with event handlers
// and use emit.isDone after asynchronous operations before calling emit() to
// ensure the event handler has not completed.

//   **BAD**
//     on<Event>((event, emit) {

// future.whenComplete(() => emit(...));
//   });

//     **GOOD**
//       on<Event>((event, emit) async {
//             await future.whenComplete(() => emit(...));
//               });

  // void _onPuzzleInitialized(
  //   PuzzleInitialized event,
  //   Emitter<PuzzleState> emit,
  // ) {
  //   final puzzle = _generatePuzzle(_size, shuffle: event.shufflePuzzle);
  //   emit(
  //     PuzzleState(
  //       puzzle: puzzle.sort(),
  //       numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
  //     ),
  //   );
  // }

  // void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
  //   final tappedTile = event.tile;
  //   if (state.puzzleStatus == PuzzleStatus.incomplete) {
  //     if (state.puzzle.isTileMovable(tappedTile)) {
  //       final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
  //       final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
  //       if (puzzle.isComplete()) {
  //         emit(
  //           state.copyWith(
  //             puzzle: puzzle.sort(),
  //             puzzleStatus: PuzzleStatus.complete,
  //             tileMovementStatus: TileMovementStatus.moved,
  //             numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
  //             numberOfMoves: state.numberOfMoves + 1,
  //             lastTappedTile: tappedTile,
  //           ),
  //         );
  //       } else {
  //         emit(
  //           state.copyWith(
  //             puzzle: puzzle.sort(),
  //             tileMovementStatus: TileMovementStatus.moved,
  //             numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
  //             numberOfMoves: state.numberOfMoves + 1,
  //             lastTappedTile: tappedTile,
  //           ),
  //         );
  //       }
  //     } else {
  //       emit(
  //         state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
  //       );
  //     }
  //   } else {
  //     emit(
  //       state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
  //     );
  //   }
  // }

  // /// Build a randomized, solvable puzzle of the given size.
  // Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
  //   final correctPositions = <Position>[];
  //   final currentPositions = <Position>[];
  //   final whitespacePosition = Position(x: size, y: size);

  //   // Create all possible board positions.
  //   for (var y = 1; y <= size; y++) {
  //     for (var x = 1; x <= size; x++) {
  //       if (x == size && y == size) {
  //         correctPositions.add(whitespacePosition);
  //         currentPositions.add(whitespacePosition);
  //       } else {
  //         final position = Position(x: x, y: y);
  //         correctPositions.add(position);
  //         currentPositions.add(position);
  //       }
  //     }
  //   }

  //   if (shuffle) {
  //     // Randomize only the current tile posistions.
  //     currentPositions.shuffle(random);
  //   }

  //   var tiles = _getTileListFromPositions(
  //     size,
  //     correctPositions,
  //     currentPositions,
  //   );

  //   var puzzle = Puzzle(tiles: tiles);

  //   if (shuffle) {
  //     // Assign the tiles new current positions until the puzzle is solvable and
  //     // zero tiles are in their correct position.
  //     while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
  //       currentPositions.shuffle(random);
  //       tiles = _getTileListFromPositions(
  //         size,
  //         correctPositions,
  //         currentPositions,
  //       );
  //       puzzle = Puzzle(tiles: tiles);
  //     }
  //   }

  //   return puzzle;
  // }

  // /// Build a list of tiles - giving each tile their correct position and a
  // /// current position.
  // List<Tile> _getTileListFromPositions(
  //   int size,
  //   List<Position> correctPositions,
  //   List<Position> currentPositions,
  // ) {
  //   final whitespacePosition = Position(x: size, y: size);
  //   return [
  //     for (int i = 1; i <= size * size; i++)
  //       if (i == size * size)
  //         Tile(
  //           value: i,
  //           correctPosition: whitespacePosition,
  //           currentPosition: currentPositions[i - 1],
  //           isWhitespace: true,
  //         )
  //       else
  //         Tile(
  //           value: i,
  //           correctPosition: correctPositions[i - 1],
  //           currentPosition: currentPositions[i - 1],
  //         )
  //   ];
  // }
}

class CalculateMoveParam {
  final Game game;
  final List<Board> hintStack;

  CalculateMoveParam(this.game, this.hintStack);
}

Hint calculateMove(CalculateMoveParam params) {
  return params.game.getBoardHint(params.hintStack);
}
