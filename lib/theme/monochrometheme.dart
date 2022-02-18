import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzletheme.dart';

class MonochromeTheme extends PuzzleTheme {
  const MonochromeTheme() : super();

  @override
  String get name => 'Monochrome';

  @override
  Color tileBackColor(int value, int boarSize) =>PuzzleColors.white;
  @override
  Color tileBorderColor(int value) => PuzzleColors.transparent;
  @override
  Color tileTextColor(int value) => PuzzleColors.black;

  @override
  Color get boardBackColor => PuzzleColors.black;
  @override
  Color get boardBorderColor => PuzzleColors.grey1;

  @override
  Color get pageBackground => PuzzleColors.black;

  @override
  Color get controlButtonColor => Colors.grey.shade900;
  @override
  Color get controlButtonSurfaceColor => Colors.grey;

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
