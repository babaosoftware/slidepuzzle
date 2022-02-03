import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gamestate.dart';
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        _controller = AnimationController(
          duration: Duration(milliseconds: state.newGame ? 2000: 300),
          vsync: this,
        );
        _controller.forward();
        return Container(
          decoration: const BoxDecoration(
            color: PuzzleColors.boardBackColor,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border(
              top: BorderSide(width: 2.0, color: PuzzleColors.boardBorderColor),
              left: BorderSide(width: 2.0, color: PuzzleColors.boardBorderColor),
              right: BorderSide(width: 2.0, color: PuzzleColors.boardBorderColor),
              bottom: BorderSide(width: 2.0, color: PuzzleColors.boardBorderColor),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(
              width: TileSizes.tileSize * state.currentBoard.size,
              height: TileSizes.tileSize * state.currentBoard.size,
              child: Stack(
                children: makeTiles(state),
              ),
            ),
          ),
        );
      }
    );
  }

  List<Widget> makeTiles(GameState state) {
    List<Widget> tiles = [];
    for (int i = 0; i < state.currentBoard.size; i++) {
      for (int j = 0; j < state.currentBoard.size; j++) {
        tiles.add(makeTile(state, i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(GameState state, int currenti, int currentj) {
    Size parentSize = Size(TileSizes.tileSize * state.currentBoard.size, TileSizes.tileSize * state.currentBoard.size);
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
      return Positioned(left: TileSizes.tileSize * currentj, top: TileSizes.tileSize * currenti, child: tile);
    } else {
      return PositionedTransition(
        rect: RelativeRectTween(
          begin:
              RelativeRect.fromSize(Rect.fromLTWH(TileSizes.tileSize * prevj, TileSizes.tileSize * previ, TileSizes.tileSize, TileSizes.tileSize), parentSize),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(TileSizes.tileSize * currentj, TileSizes.tileSize * currenti, TileSizes.tileSize, TileSizes.tileSize), parentSize),
        ).animate(CurvedAnimation(parent: _controller, curve: state.newGame ? Curves.easeInOutQuart : Curves.linear)),
        child: tile,
      );
    }
  }
}
