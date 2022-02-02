import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/hint.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/controlbloc.dart';
import 'package:slidepuzzle/widgets/controlpanel.dart';
import 'package:slidepuzzle/widgets/tileboard.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title, required this.boardType, required this.boardSize}) : super(key: key);
  final String title;
  final BoardType boardType;
  final int boardSize;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<Board> _hintStack;
  late Game _startGame;
  late Game _game;
  late Board _currentBoard;
  late Board _prevBoard;
  final autoPlayCubit = AutoPlayCubit();
  final newGameCubit = NewGameCubit();
  final restartGameCubit = RestartGameCubit();
  final tileClickCubit = TileClickCubit();
  final gameCounterCubit = GameCounterCubit();
  final hintCubit = HintCubit();

  bool isAutoPlay = false;

  void oneMove(bool auto) async {
    if (auto && !isAutoPlay) return;
    Hint hint = await calculateNextMove(_game, _hintStack);
    if (!mounted || auto && !isAutoPlay) return;
    gameCounterCubit.stepUp();
    if (_game.moveValue(hint.value)) _hintStack.add(Board.copy(_game.getGameBoard()));
    if (!_game.checkGameSolved() && auto) {
      Timer(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        oneMove(true);
      });
    } else if (auto) {
      autoPlayCubit.flip();
    }
    Timer(const Duration(milliseconds: 10), () {
      if (!mounted) return;
      setState(() {
        _prevBoard = Board.copy(_currentBoard);
        _currentBoard = Board.copy(_game.getGameBoard());
      });
    });
  }

  void newGame() {
    gameCounterCubit.reset();
    setState(() {
      _hintStack = [];
      _game = Game(widget.boardType, widget.boardSize);
      _startGame = Game.copy(_game);
      _currentBoard = Board.copy(_game.getGameBoard());
      _prevBoard = Board.copy(_game.getGameBoard());
    });
  }

  void restartGame() {
    gameCounterCubit.reset();
    setState(() {
      _hintStack = [];
      _game = Game.copy(_startGame);
      _currentBoard = Board.copy(_game.getGameBoard());
      _prevBoard = Board.copy(_game.getGameBoard());
    });
  }

  void moveTile(int value) {
    if (value == -1) return;
    if (_game.moveValue(value)) {
      gameCounterCubit.stepUp();
      Timer(const Duration(milliseconds: 10), () {
        setState(() {
          _hintStack = [];
          _prevBoard = Board.copy(_currentBoard);
          _currentBoard = Board.copy(_game.getGameBoard());
        });
      });
      if (_game.checkGameSolved()) {}
    }
  }

  @override
  void initState() {
    super.initState();
    newGame();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return Scaffold(
        backgroundColor: PuzzleColors.gameBack,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => autoPlayCubit),
            BlocProvider(create: (context) => newGameCubit),
            BlocProvider(create: (context) => restartGameCubit),
            BlocProvider(create: (context) => tileClickCubit),
            BlocProvider(create: (context) => gameCounterCubit),
            BlocProvider(create: (context) => hintCubit),
          ],
          child: MultiBlocListener(
              listeners: [
                BlocListener<AutoPlayCubit, bool>(listener: (context, state) {
                  isAutoPlay = state;
                  if (state) oneMove(true);
                }),
                BlocListener<NewGameCubit, bool>(listener: (context, state) {
                  newGame();
                }),
                BlocListener<RestartGameCubit, bool>(listener: (context, state) {
                  restartGame();
                }),
                BlocListener<TileClickCubit, int>(listener: (context, state) {
                  moveTile(state);
                }),
                BlocListener<HintCubit, bool>(listener: (context, state) {
                  oneMove(false);
                }),
              ],
              child: Center(
                child: smallScreen
                    ? Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets())
                    : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets()),
              )),
        ));
  }

  List<Widget> buildWidgets() {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;
    return [
      TileBoard(
        _currentBoard,
        _prevBoard,
      ),
      smallScreen
          ? Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(width: TileSizes.tileSize * _game.gameSize, child: const ControlPanel()),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(width: TileSizes.tileSize * _game.gameSize, child: const ControlPanel()),
            )
    ];
  }
}

Future<Hint> calculateNextMove(Game game, List<Board> hintStack) {
  return compute(calculateMove, game);
}

Hint calculateMove(Game game) {
  return game.getBoardHint([]);
}
