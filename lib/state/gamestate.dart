import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/targetboard.dart';

enum BoardState { loading, start, ongoing, hint, end }

class GameState extends Equatable {
  GameState(
    this.boardType,
    this.boardSize,
  ) {
    hintStack = [];
    game = Game(boardType, boardSize, newGame: false);
    startGame = Game.copy(game);
    currentBoard = Board.copy(game.getGameBoard());
    prevBoard = Board.copy(currentBoard);
    autoPlay = false;
    boardState = BoardState.loading;
    counter = 0;
  }

  GameState.copy(this.boardType, this.boardSize, this.hintStack, this.game, this.startGame, this.currentBoard, this.prevBoard, this.autoPlay, this.boardState, this.counter);

  GameState copyWith({
    BoardType? boardType,
    int? boardSize,
    List<Board>? hintStack,
    Game? game,
    Game? startGame,
    Board? currentBoard,
    Board? prevBoard,
    bool? autoPlay,
    BoardState? boardState,
    int? counter,
  }) {
    return GameState.copy(boardType ?? this.boardType, boardSize ?? this.boardSize, hintStack ?? this.hintStack, game ?? this.game, startGame ?? this.startGame,
        currentBoard ?? this.currentBoard, prevBoard ?? this.prevBoard, autoPlay ?? this.autoPlay, boardState ?? this.boardState, counter ?? this.counter);
  }

  final BoardType boardType;
  final int boardSize;
  late final List<Board> hintStack;
  late final Game startGame;
  late final Game game;
  late final Board currentBoard;
  late final Board prevBoard;
  late final bool autoPlay;
  late final BoardState boardState;
  late final int counter;

  static int stateTransitionTime(BoardState boardState) {
    switch (boardState) {
      case BoardState.loading:
        return 2000;
      case BoardState.start:
        return 1000;
      case BoardState.ongoing:
        return 300;
      case BoardState.end:
        return 300;
      case BoardState.hint:
        return 300;
    }
  }

  @override
  List<Object?> get props => [game, currentBoard, autoPlay, boardState, counter];
}
