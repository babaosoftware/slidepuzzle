import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/targetboard.dart';

class GameState extends Equatable {
  GameState(
    this.boardType,
    this.boardSize,
  ) {
    hintStack = [];
    game = Game(boardType, boardSize);
    startGame = Game.copy(game);
    currentBoard = Board.copy(game.getGameBoard());
    prevBoard = Board(boardSize, createTargetBoard(boardSize, boardType));
    autoPlay = false;
    newGame = true;
    solved = false;
  }

  GameState.copy(this.boardType, this.boardSize, this.hintStack, this.game, this.startGame, this.currentBoard, this.prevBoard, this.autoPlay, this.newGame, this.solved);

  GameState copyWith({
    BoardType? boardType,
    int? boardSize,
    List<Board>? hintStack,
    Game? game,
    Game? startGame,
    Board? currentBoard,
    Board? prevBoard,
    bool? autoPlay,
    bool? newGame,
    bool? solved,
  }) {
    return GameState.copy(boardType ?? this.boardType, boardSize ?? this.boardSize, hintStack ?? this.hintStack, game ?? this.game, startGame ?? this.startGame,
        currentBoard ?? this.currentBoard, prevBoard ?? this.prevBoard, autoPlay ?? this.autoPlay, newGame ?? this.newGame, solved ?? this.solved);
  }

  final BoardType boardType;
  final int boardSize;
  late final List<Board> hintStack;
  late final Game startGame;
  late final Game game;
  late final Board currentBoard;
  late final Board prevBoard;
  late final bool autoPlay;
  late final bool newGame;
  late final bool solved;

  @override
  List<Object?> get props => [game, currentBoard, autoPlay, newGame, solved];
}
