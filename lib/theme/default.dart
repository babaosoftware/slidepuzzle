import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class DefaultTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const DefaultTheme() : super();

  @override
  String get name => 'Default';

  @override
  Color tileBackColor(int value) => value.isEven ? PuzzleColors.cellEvenBackColor : PuzzleColors.cellOddBackColor;
  @override
  Color tileBorderColor(int value) => value.isEven ? PuzzleColors.cellBorderColorOdd : PuzzleColors.cellBorderColorEven;
  @override
  Color tileTextColor(int value) => value.isEven ? PuzzleColors.cellEvenTextColor : PuzzleColors.cellOddTextColor;

  @override
  Color get boardBackColor => PuzzleColors.boardBackColor;
  @override
  Color get boardBorderColor => PuzzleColors.boardBorderColor;

  @override
  Color get pageBackground => PuzzleColors.gameBack;

  @override
  double get tileRadius => 12.0;

  @override
  DecorationImage? tileImageBackground(int value) => null;

  @override
  double get tileSize => 70;
  @override
  double get fontSize => 35;
  @override
  double get lightTileSize => 50;
  @override
  double get lightFontSize => 15;

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
