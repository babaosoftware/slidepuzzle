import 'dart:async';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sliding Puzzle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Board> _hintStack;
  late Game _startGame;
  late Game _game;
  late Board _currentBoard;
  late Board _prevBoard;
  late Hint hint;

  bool isAutoPlay = false;

  void autoPlay() {
    if (!isAutoPlay) return;
    hint = _game.getBoardHint(_hintStack);
    _game.moveValue(hint.value);
    if (!_game.checkGameSolved()) {
      Timer(const Duration(milliseconds: 500), () {
        autoPlay();
      });
    } else {
      autoPlayCubit.flip();
    }
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _prevBoard = Board.copy(_currentBoard);
        _currentBoard = Board.copy(_game.getGameBoard());
      });
    });
  }

  void newGame() {
    setState(() {
      _hintStack = [];
      _game = Game(BoardType.snake, 4);
      _startGame = Game.copy(_game);
      _currentBoard = Board.copy(_game.getGameBoard());
      _prevBoard = Board.copy(_game.getGameBoard());
    });
  }

  void restartGame() {
    setState(() {
      _hintStack = [];
      _game = Game.copy(_startGame);
      _currentBoard = Board.copy(_game.getGameBoard());
      _prevBoard = Board.copy(_game.getGameBoard());
    });
  }

  void moveTile(int value) {
    if (value == -1) return;
    _game.moveValue(value);
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _hintStack = [];
        _prevBoard = Board.copy(_currentBoard);
        _currentBoard = Board.copy(_game.getGameBoard());
      });
    });
    if (_game.checkGameSolved()) {}
  }

  @override
  void initState() {
    super.initState();
    newGame();
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
          ],
          child: MultiBlocListener(
              listeners: [
                BlocListener<AutoPlayCubit, bool>(listener: (context, state) {
                  isAutoPlay = state;
                  if (state) autoPlay();
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
