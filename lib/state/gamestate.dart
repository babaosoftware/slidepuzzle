import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/targetboard.dart';

enum BoardState { loading, start, ongoing, hint, end }

class GameState extends Equatable {
  GameState(this.boardType, this.boardSize, {this.isArena = false}) {
    hintStack = [];
    game = Game(boardType, boardSize, newGame: false);
    startGame = Game.copy(game);
    currentBoard = Board.copy(game.getGameBoard());
    prevBoard = Board.copy(currentBoard);
    autoPlay = false;
    boardState = BoardState.loading;
    counter = 0;
    initialized = false;
    hintStackComputer = [];
    gameComputer = Game.copy(game);
    currentBoardComputer = Board.copy(gameComputer.getGameBoard());
    prevBoardComputer = Board.copy(currentBoardComputer);
  }

  GameState.copy(this.boardType, this.boardSize, this.isArena, this.hintStack, this.game, this.startGame, this.currentBoard, this.prevBoard, this.autoPlay,
      this.boardState, this.counter, this.initialized, this.hintStackComputer, this.gameComputer, this.currentBoardComputer, this.prevBoardComputer);

  GameState copyWith({
    BoardType? boardType,
    int? boardSize,
    bool? isArena,
    List<Board>? hintStack,
    Game? game,
    Game? startGame,
    Board? currentBoard,
    Board? prevBoard,
    bool? autoPlay,
    BoardState? boardState,
    int? counter,
    bool? initialized,
    List<Board>? hintStackComputer,
    Game? gameComputer,
    Board? currentBoardComputer,
    Board? prevBoardComputer,
  }) {
    return GameState.copy(
        boardType ?? this.boardType,
        boardSize ?? this.boardSize,
        isArena ?? this.isArena,
        hintStack ?? this.hintStack,
        game ?? this.game,
        startGame ?? this.startGame,
        currentBoard ?? this.currentBoard,
        prevBoard ?? this.prevBoard,
        autoPlay ?? this.autoPlay,
        boardState ?? this.boardState,
        counter ?? this.counter,
        initialized ?? this.initialized,
        hintStackComputer ?? this.hintStackComputer,
        gameComputer ?? this.gameComputer,
        currentBoardComputer ?? this.currentBoardComputer,
        prevBoardComputer ?? this.prevBoardComputer,
        );
  }

  final BoardType boardType;
  final int boardSize;
  final bool isArena;
  late final List<Board> hintStack;
  late final Game startGame;
  late final Game game;
  late final Board currentBoard;
  late final Board prevBoard;
  late final bool autoPlay;
  late final BoardState boardState;
  late final int counter;
  late final bool initialized;
  late final List<Board> hintStackComputer;
  late final Game gameComputer;
  late final Board currentBoardComputer;
  late final Board prevBoardComputer;

  static int stateTransitionTime(BoardState boardState) {
    switch (boardState) {
      case BoardState.loading:
        return 1000;
      case BoardState.start:
        return 700;
      case BoardState.ongoing:
        return 300;
      case BoardState.end:
        return 300;
      case BoardState.hint:
        return 300;
    }
  }

  @override
  List<Object?> get props => [game, currentBoard, autoPlay, boardState, counter, gameComputer, currentBoardComputer];
}
