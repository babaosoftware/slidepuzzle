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
    // on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileClick>(_onTileClick);
    on<NewGame>(_onNewGame);
    on<RestartGame>(_onRestartGame);
    on<StartAutoPlay>(_onStartAutoPlay);
    on<GameHint>(_onGameHint);
    on<GameHintReceived>(_onGameHintReceived);
    on<GameBack>(_onGameBack);
  }

  final BoardType boardType;
  final int boardSize;

  void _onTileClick(TileClick event, Emitter<GameState> emit) {
    if (state.game.moveValue(event.value)) {
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

  void _onNewGame(NewGame event, Emitter<GameState> emit) {
    Game newGame = Game(boardType, boardSize);
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

  void _onGameBack(GameBack event, Emitter<GameState> emit) {
    Game backGame = Game.copy(state.game);
    backGame.moveBack();
    emit(state.copyWith(
      game: backGame,
      hintStack: [],
      prevBoard: Board.copy(state.game.getGameBoard()),
      currentBoard: Board.copy(backGame.getGameBoard()),
      counter: state.counter - 1,
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
    if (state.game.moveValue(event.value)) {
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

  void _onGameHint(GameHint event, Emitter<GameState> emit) {
    GameState newState = state.copyWith(boardState: BoardState.hint, prevBoard: Board.copy(state.currentBoard));
    emit(newState);
    Timer(const Duration(milliseconds: 500), () async {
      // final stopwatch = Stopwatch();
      // stopwatch.start();
      Hint hint = await calculateNextMove(Game.copy(state.game), state.hintStack);
      // int elapsed = stopwatch.elapsedMilliseconds;
      // stopwatch.stop();
      // int transitionTime = GameState.stateTransitionTime(BoardState.hint);
      // if (elapsed < transitionTime) {
      //   Timer(Duration(milliseconds: transitionTime - elapsed), () {
      //     add(GameHintReceived(hint.value));
      //   });
      // } else {
      add(GameHintReceived(hint.value));
      // }
    });
  }

  void _onStartAutoPlay(StartAutoPlay event, Emitter<GameState> emit) {
    // emit(state.copyWith(
    //     game: Game.copy(state.startGame),
    //     boardState: BoardState.start,
    //     hintStack: [],
    //     prevBoard: Board.copy(state.game.getGameBoard()),
    //     currentBoard: Board.copy(state.startGame.getGameBoard())));
  }

  Future<Hint> calculateNextMove(Game game, List<Board> hintStack) {
    return compute(calculateMove, game);
  }

  Hint calculateMove(Game game) {
    return game.getBoardHint([]);
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
