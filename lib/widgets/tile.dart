import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/typography/text_styles.dart';

class Tile extends StatelessWidget {
  const Tile(this.value, this.isEmpty, {this.light = false, Key? key}) : super(key: key);

  final int value;
  final bool isEmpty;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: light ? TileSizes.lightTileSize : TileSizes.tileSize,
      height: light ? TileSizes.lightTileSize : TileSizes.tileSize,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            color: isEmpty ? PuzzleColors.transparent : (value.isEven ? PuzzleColors.cellEvenBackColor : PuzzleColors.cellOddBackColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: isEmpty
                ? const Border()
                : const Border(
                    top: BorderSide(width: 2.0, color: PuzzleColors.cellBorderColorOdd),
                    left: BorderSide(width: 2.0, color: PuzzleColors.cellBorderColorOdd),
                    right: BorderSide(width: 2.0, color: PuzzleColors.cellBorderColorOdd),
                    bottom: BorderSide(width: 2.0, color: PuzzleColors.cellBorderColorOdd),
                  ),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: PuzzleColors.white,
              disabledMouseCursor: light ? SystemMouseCursors.click : SystemMouseCursors.basic,
              enabledMouseCursor: light ? SystemMouseCursors.click : SystemMouseCursors.click,
              textStyle: PuzzleTextStyle.headline2.copyWith(
                fontSize: light ? TileSizes.lightFontSize : TileSizes.fontSize,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ).copyWith(
              foregroundColor: MaterialStateProperty.all(value.isEven ? PuzzleColors.cellEvenTextColor : PuzzleColors.cellOddTextColor),
              backgroundColor: MaterialStateProperty.all(
                  isEmpty ? PuzzleColors.transparent : (value.isEven ? PuzzleColors.cellEvenBackColor : PuzzleColors.cellOddBackColor)),
            ),
            onPressed: light || isEmpty
                ? null
                : () {
                    context.read<GameBloc>().add(TileClick(value));
                  },
            child: Text(isEmpty ? '' : value.toString()),
          ),
        ),
      ),
    );
  }
}
