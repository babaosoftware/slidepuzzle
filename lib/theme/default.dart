import 'dart:ui';

import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class DefaultTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const DefaultTheme() : super();

  @override
  String get name => 'Default';

  @override
  Color get evenTileBackColor => PuzzleColors.cellEvenBackColor;
  @override
  Color get oddTileBackColor => PuzzleColors.cellOddBackColor;

  @override
  Color get evenTileBorderColor => PuzzleColors.cellBorderColorOdd;
  @override
  Color get oddTileBorderColor => PuzzleColors.cellBorderColorEven;

  @override
  Color get evenTileTextColor => PuzzleColors.cellEvenTextColor;
  @override
  Color get oddTileTextColor => PuzzleColors.cellOddTextColor;

  @override
  Color get boardBackColor => PuzzleColors.boardBackColor;
  @override
  Color get boardBorderColor => PuzzleColors.boardBorderColor;

  @override
  String get tileClickSound => 'audio/tilemove.wav';

  @override
  String tileValue(int value) {
    return value.toString();
  }

  @override
  List<Object?> get props => [
        name,
        evenTileBackColor,
        oddTileBackColor,
        evenTileBorderColor,
        oddTileBorderColor,
        evenTileTextColor,
        oddTileTextColor,
        tileClickSound,
        tileValue,
      ];
}
