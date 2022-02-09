import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/widgets/tile.dart';

class TileBoard extends StatefulWidget {
  const TileBoard({Key? key}) : super(key: key);

  @override
  _TileBoardState createState() => _TileBoardState();
}

class _TileBoardState extends State<TileBoard> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool firstBuild = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: GameState.stateTransitionTime(BoardState.loading) + 10), () {
      if (mounted) {
        context.read<GameBloc>().add(const InitializeGame());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      _controller = AnimationController(
        duration: Duration(milliseconds: GameState.stateTransitionTime(state.boardState)),
        vsync: this,
      );
      _controller.forward();
      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {return Container(
        decoration: BoxDecoration(
          color: themeState.theme.boardBackColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          border: Border(
            top: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor),
            left: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor),
            right: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor),
            bottom: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: SizedBox(
            width: themeState.theme.tileSize * state.currentBoard.size,
            height: themeState.theme.tileSize * state.currentBoard.size,
            child: Stack(
              children: makeTiles(state, themeState),
            ),
          ),
        ),
      );});
    });
  }

  List<Widget> makeTiles(GameState state, ThemeState themeState) {
    List<Widget> tiles = [];
    for (int i = 0; i < state.currentBoard.size; i++) {
      for (int j = 0; j < state.currentBoard.size; j++) {
        tiles.add(makeTile(state, themeState, i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(GameState state, ThemeState themeState, int currenti, int currentj) {
    Size parentSize = Size(themeState.theme.tileSize * state.currentBoard.size, themeState.theme.tileSize * state.currentBoard.size);
    var board = state.currentBoard.board;
    var prevBoard = state.prevBoard.board;
    int previ = 0;
    int prevj = 0;

    for (int i = 0; i < state.currentBoard.size; i++) {
      bool found = false;
      for (int j = 0; j < state.currentBoard.size; j++) {
        if (board[currenti][currentj] == prevBoard[i][j]) {
          previ = i;
          prevj = j;
          found = true;
          break;
        }
      }
      if (found) break;
    }

    bool samePos = currenti == previ && currentj == prevj;

    Tile tile = Tile(board[currenti][currentj], board[currenti][currentj] == state.currentBoard.emptyCellValue, key: Key(board[currenti][currentj].toString()));

    if (samePos) {
      return Positioned(left: themeState.theme.tileSize * currentj, top: themeState.theme.tileSize * currenti, child: tile);
    } else {
      return PositionedTransition(
        rect: RelativeRectTween(
          begin:
              RelativeRect.fromSize(Rect.fromLTWH(themeState.theme.tileSize * prevj, themeState.theme.tileSize * previ, themeState.theme.tileSize, themeState.theme.tileSize), parentSize),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(themeState.theme.tileSize * currentj, themeState.theme.tileSize * currenti, themeState.theme.tileSize, themeState.theme.tileSize), parentSize),
        ).animate(CurvedAnimation(parent: _controller, curve: state.boardState == BoardState.start ? Curves.easeInOutQuart : Curves.linear)),
        child: tile,
      );
    }
  }
}
