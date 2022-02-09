import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';
import 'package:slidepuzzle/widgets/tile.dart';

class TileBoard extends StatefulWidget {
  const TileBoard({this.isComputer = false, Key? key}) : super(key: key);

  final bool isComputer;

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
            width: TileSizes.tileSize * currentBoard(state).size,
            height: TileSizes.tileSize * currentBoard(state).size,
            child: Stack(
              children: makeTiles(state),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> makeTiles(GameState state) {
    List<Widget> tiles = [];
    for (int i = 0; i < currentBoard(state).size; i++) {
      for (int j = 0; j < currentBoard(state).size; j++) {
        tiles.add(makeTile(state, i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(GameState state, int currenti, int currentj) {
    Size parentSize = Size(TileSizes.tileSize * currentBoard(state).size, TileSizes.tileSize * currentBoard(state).size);
    var board = currentBoard(state).board;
    var pBoard = prevBoard(state).board;
    int previ = 0;
    int prevj = 0;

    for (int i = 0; i < currentBoard(state).size; i++) {
      bool found = false;
      for (int j = 0; j < currentBoard(state).size; j++) {
        if (board[currenti][currentj] == pBoard[i][j]) {
          previ = i;
          prevj = j;
          found = true;
          break;
        }
      }
      if (found) break;
    }

    bool samePos = currenti == previ && currentj == prevj;

    Tile tile =
        Tile(board[currenti][currentj], board[currenti][currentj] == currentBoard(state).emptyCellValue, key: Key(board[currenti][currentj].toString()));

    if (samePos) {
      return Positioned(left: TileSizes.tileSize * currentj, top: TileSizes.tileSize * currenti, child: tile);
    } else {
      return PositionedTransition(
        rect: RelativeRectTween(
          begin:
              RelativeRect.fromSize(Rect.fromLTWH(TileSizes.tileSize * prevj, TileSizes.tileSize * previ, TileSizes.tileSize, TileSizes.tileSize), parentSize),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(TileSizes.tileSize * currentj, TileSizes.tileSize * currenti, TileSizes.tileSize, TileSizes.tileSize), parentSize),
        ).animate(CurvedAnimation(parent: _controller, curve: state.boardState == BoardState.start ? Curves.easeInOutQuart : Curves.linear)),
        child: tile,
      );
    }
  }

  Board currentBoard(GameState state) => widget.isComputer ? state.currentBoardComputer : state.currentBoard;
  Board prevBoard(GameState state) => widget.isComputer ? state.prevBoardComputer : state.prevBoard;
}
