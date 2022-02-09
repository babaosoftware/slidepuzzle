import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  DecorationImage? tileImageBackground(int value);

  double get tileSize;
  double get fontSize;
  double get lightTileSize;
  double get lightFontSize;

  String get tileClickSound;

  String tileValue(int value);

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  // PuzzleLayoutDelegate get layoutDelegate;
}
