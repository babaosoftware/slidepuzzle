import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/typography/text_styles.dart';

class Tile extends StatelessWidget {
  const Tile(this.value, this.isEmpty, {Key? key}) : super(key: key);

  final int value;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: TileSizes.tileSize,
        height: TileSizes.tileSize,
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
                textStyle: PuzzleTextStyle.headline2.copyWith(
                  fontSize: TileSizes.fontSize,
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
              onPressed: isEmpty
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
