
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/widgets/tile.dart';

class TileBoardLight extends StatelessWidget {
  const TileBoardLight(this.board, {Key? key}) : super(key: key);
  final Board board;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {return Container(
      decoration: const BoxDecoration(
        color: PuzzleColors.boardBackColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        border: Border(
          top: BorderSide(width: 1.0, color: PuzzleColors.boardBorderColor),
          left: BorderSide(width: 1.0, color: PuzzleColors.boardBorderColor),
          right: BorderSide(width: 1.0, color: PuzzleColors.boardBorderColor),
          bottom: BorderSide(width: 1.0, color: PuzzleColors.boardBorderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SizedBox(
          width: themeState.theme.lightTileSize * board.size,
          height: themeState.theme.lightTileSize * board.size,
          child: Stack(
            children: makeTiles(themeState),
          ),
        ),
      ),
    );});
  }

  List<Widget> makeTiles(ThemeState themeState) {
    List<Widget> tiles = [];
    for (int i = 0; i < board.size; i++) {
      for (int j = 0; j < board.size; j++) {
        tiles.add(makeTile(themeState, i, j));
      }
    }
    return tiles;
  }

  Widget makeTile(ThemeState themeState, int currenti, int currentj) {
    Tile tile = Tile(board.board[currenti][currentj], board.board[currenti][currentj] == board.emptyCellValue, key: Key(board.board[currenti][currentj].toString()), light: true,);
    return Positioned(left: themeState.theme.lightTileSize * currentj, top: themeState.theme.lightTileSize * currenti, child: tile);
  }
}
