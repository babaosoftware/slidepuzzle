import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/widgets/tile.dart';

class TileBoardLight extends StatefulWidget {
  const TileBoardLight(this.board, {Key? key}) : super(key: key);
  final Board board;

  @override
  State<TileBoardLight> createState() => _TileBoardLightState();
}

class _TileBoardLightState extends State<TileBoardLight> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            this.hasFocus = hasFocus;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: themeState.theme.boardBackColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border(
              top: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor(hasFocus)),
              left: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor(hasFocus)),
              right: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor(hasFocus)),
              bottom: BorderSide(width: 2.0, color: themeState.theme.boardBorderColor(hasFocus)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SizedBox(
              width: themeState.theme.lightTileSize * widget.board.size,
              height: themeState.theme.lightTileSize * widget.board.size,
              child: Stack(
                children: makeTiles(themeState),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> makeTiles(ThemeState themeState) {
    List<Widget> tiles = [];
    for (int i = 0; i < widget.board.size; i++) {
      for (int j = 0; j < widget.board.size; j++) {
        tiles.add(makeTile(themeState, i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(ThemeState themeState, int currenti, int currentj) {
    Tile tile = Tile(
      widget.board.board[currenti][currentj],
      widget.board.board[currenti][currentj] == widget.board.emptyCellValue,
      widget.board.size,
      key: Key(widget.board.board[currenti][currentj].toString()),
      light: true,
    );
    return Positioned(left: themeState.theme.lightTileSize * currentj, top: themeState.theme.lightTileSize * currenti, child: tile);
  }
}
