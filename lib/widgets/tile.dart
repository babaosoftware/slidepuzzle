import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
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
            foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
            backgroundColor: MaterialStateProperty.all(isEmpty ? PuzzleColors.transparent : PuzzleColors.primary5),
          ),
          onPressed: null,
          child: Text(isEmpty ? '' : value.toString()),
        ),
      ),
    );
  }
}
