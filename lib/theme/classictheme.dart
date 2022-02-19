import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzletheme.dart';

class ClassicTheme extends PuzzleTheme {
  const ClassicTheme() : super();

  @override
  String get name => 'Classic';

  @override
  Color tileBackColor(int value, int boarSize) => value.isEven ? PuzzleColors.cellEvenBackColor : PuzzleColors.cellOddBackColor;
  @override
  Color tileBorderColor(int value) => value.isEven ? PuzzleColors.cellBorderColorOdd : PuzzleColors.cellBorderColorEven;
  @override
  Color tileTextColor(int value) => value.isEven ? PuzzleColors.cellEvenTextColor : PuzzleColors.cellOddTextColor;

  @override
  Color get boardBackColor => PuzzleColors.boardBackColor;
  @override
  Color boardBorderColor(bool hasFocus) => hasFocus ? PuzzleColors.white : PuzzleColors.boardBorderColor;

  @override
  Color get pageBackground => PuzzleColors.gameBack;

  @override
  double get tileRadius => 12.0;

  @override
  DecorationImage? tileImageBackground(int value) => null;

  @override
  String get tileClickSound => 'audio/tilemove.wav';

  @override
  String tileValue(int value) {
    return value.toString();
  }

  @override
  List<Object?> get props => [
        name,
        tileBackColor,
        tileBorderColor,
        tileTextColor,
        tileClickSound,
        tileValue,
      ];
}
