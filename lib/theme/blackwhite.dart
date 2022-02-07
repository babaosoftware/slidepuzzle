import 'dart:ui';

import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class BlackWhiteTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const BlackWhiteTheme() : super();

  @override
  String get name => 'BlackWhite';

  @override
  Color get evenTileBackColor => PuzzleColors.white;
  @override
  Color get oddTileBackColor => PuzzleColors.white;

  @override
  Color get evenTileBorderColor => PuzzleColors.black;
  @override
  Color get oddTileBorderColor => PuzzleColors.black;

  @override
  Color get evenTileTextColor => PuzzleColors.black;
  @override
  Color get oddTileTextColor => PuzzleColors.black;

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
