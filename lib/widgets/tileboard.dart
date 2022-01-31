import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/widgets/tile.dart';

class TileBoard extends StatefulWidget {
  const TileBoard(this.board, this.prevBoard, {Key? key}) : super(key: key);
  final Board board;
  final Board prevBoard;

  @override
  _TileBoardState createState() => _TileBoardState();
}

class _TileBoardState extends State<TileBoard> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

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
    _controller.reset();
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
          width: TileSizes.tileSize * widget.board.size,
          height: TileSizes.tileSize * widget.board.size,
          child: Stack(
            children: makeTiles(),
          ),
        ),
      ),
    );
  }

  List<Widget> makeTiles() {
    List<Widget> tiles = [];
    for (int i = 0; i < widget.board.size; i++) {
      for (int j = 0; j < widget.board.size; j++) {
        tiles.add(makeTile(i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(int currenti, int currentj) {
    Size parentSize = Size(TileSizes.tileSize * widget.board.size, TileSizes.tileSize * widget.board.size);
    var board = widget.board.board;
    var prevBoard = widget.prevBoard.board;
    int previ = 0;
    int prevj = 0;

    for (int i = 0; i < widget.board.size; i++) {
      bool found = false;
      for (int j = 0; j < widget.board.size; j++) {
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

    Tile tile = Tile(board[currenti][currentj], board[currenti][currentj] == widget.board.emptyCellValue, key: Key(board[currenti][currentj].toString()));

    if (samePos) {
      return Positioned(left: TileSizes.tileSize * currentj, top: TileSizes.tileSize * currenti, child: tile);
    } else {
      return PositionedTransition(
        rect: RelativeRectTween(
          begin:
              RelativeRect.fromSize(Rect.fromLTWH(TileSizes.tileSize * prevj, TileSizes.tileSize * previ, TileSizes.tileSize, TileSizes.tileSize), parentSize),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(TileSizes.tileSize * currentj, TileSizes.tileSize * currenti, TileSizes.tileSize, TileSizes.tileSize), parentSize),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.linear,
        )),
        child: tile,
      );
    }
  }
}
