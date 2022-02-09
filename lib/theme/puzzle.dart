import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class PuzzleTheme extends Equatable {
  const PuzzleTheme();

  /// The display name of this theme.
  String get name;

  Color get evenTileBackColor;
  Color get oddTileBackColor;

  Color get evenTileBorderColor;
  Color get oddTileBorderColor;

  Color get evenTileTextColor;
  Color get oddTileTextColor;

  Color get boardBackColor;
  Color get boardBorderColor;

  String get tileClickSound;

  String tileValue(int value);

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  // PuzzleLayoutDelegate get layoutDelegate;
}
