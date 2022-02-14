import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/widgets/controlpanel.dart';
import 'package:slidepuzzle/widgets/themebutton.dart';
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
  late GameBloc gameBloc;

  // void oneMove(bool auto) async {
  // if (auto && !isAutoPlay) return;
  // Hint hint = await calculateNextMove(_game, _hintStack);
  // if (!mounted || auto && !isAutoPlay) return;
  // gameCounterCubit.stepUp();
  // if (_game.moveValue(hint.value)) _hintStack.add(Board.copy(_game.getGameBoard()));
  // if (!_game.checkGameSolved() && auto) {
  //   Timer(const Duration(milliseconds: 500), () {
  //     if (!mounted) return;
  //     oneMove(true);
  //   });
  // } else if (auto) {
  //   autoPlayCubit.flip();
  // }
  // Timer(const Duration(milliseconds: 10), () {
  //   if (!mounted) return;
  //   setState(() {
  //     _prevBoard = Board.copy(_currentBoard);
  //     _currentBoard = Board.copy(_game.getGameBoard());
  //   });
  // });
  // }

  // void newGame() {
  // gameCounterCubit.reset();
  // setState(() {
  //   _hintStack = [];
  //   _game = Game(widget.boardType, widget.boardSize);
  //   _startGame = Game.copy(_game);
  //   _currentBoard = Board.copy(_game.getGameBoard());
  //   _prevBoard = Board.copy(_game.getGameBoard());
  // });
  // }

  // void restartGame() {
  // gameCounterCubit.reset();
  // setState(() {
  //   _hintStack = [];
  //   _game = Game.copy(_startGame);
  //   _currentBoard = Board.copy(_game.getGameBoard());
  //   _prevBoard = Board.copy(_game.getGameBoard());
  // });
  // }

  // void moveTile(int value) {
  // if (value == -1) return;
  // if (_game.moveValue(value)) {
  //   gameCounterCubit.stepUp();
  //   Timer(const Duration(milliseconds: 10), () {
  //     setState(() {
  //       _hintStack = [];
  //       _prevBoard = Board.copy(_currentBoard);
  //       _currentBoard = Board.copy(_game.getGameBoard());
  //     });
  //   });
  //   if (_game.checkGameSolved()) {}
  // }
  // }

  @override
  void initState() {
    gameBloc = GameBloc(widget.boardType, widget.boardSize);
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return Scaffold(
        backgroundColor: themeBloc.state.theme.pageBackground,
        appBar: null,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => gameBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: Stack(children: [
            Center(
              child: smallScreen
                  ? Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets())
                  : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets()),
            ),
            Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back), color: themeBloc.state.theme.controlLabelColor,),
                    Expanded(child: Center(child: Text(widget.title, style: TextStyle(color: themeBloc.state.theme.controlLabelColor, fontSize: 36),)), flex: 1),
                    // ThemeButton(themeBloc.state.theme.name, (index, newTheme) {
                    //   themeBloc.add(ThemeChanged(themeIndex: index));
                    // })
                  ],
                ))
          ]),
        ));
  }

  List<Widget> buildWidgets() {
    return [
      const TileBoard(),
      const ControlPanel(),
    ];
  }
}
