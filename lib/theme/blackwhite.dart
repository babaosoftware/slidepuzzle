import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class BlackWhiteTheme extends PuzzleTheme {
  const BlackWhiteTheme() : super();

  @override
  String get name => 'Monochrome';

  @override
  Color tileBackColor(int value) =>PuzzleColors.white;
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
