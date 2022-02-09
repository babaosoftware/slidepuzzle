import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/widgets/controlpanel.dart';
import 'package:slidepuzzle/widgets/controlpanelarena.dart';
import 'package:slidepuzzle/widgets/tileboard.dart';

class GameArena extends StatefulWidget {
  const GameArena({Key? key, required this.title, required this.boardType, required this.boardSize}) : super(key: key);
  final String title;
  final BoardType boardType;
  final int boardSize;

  @override
  State<GameArena> createState() => _GameArenaState();
}

class _GameArenaState extends State<GameArena> {
  late GameBloc gameBloc;


  @override
  void initState() {
    gameBloc = GameBloc(widget.boardType, widget.boardSize, isArena: true);
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
        backgroundColor: PuzzleColors.gameBack,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => themeBloc),
          BlocProvider(create: (context) => gameBloc),
          ],
          child: Center(
            child: smallScreen
                ? Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets())
                : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets()),
          ),
        ));
  }

  List<Widget> buildWidgets() {
    return [
      const TileBoard(isComputer: true),
      const ControlPanelArena(),
      const TileBoard(), 
    ];
  }
}
