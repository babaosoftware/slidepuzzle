import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PuzzleTheme extends Equatable {
  const PuzzleTheme();

  String get name;

  Color tileBackColor(int value);
  Color tileBorderColor(int value);
  Color tileTextColor(int value);

  Color get boardBackColor;
  Color get boardBorderColor;

  Color get pageBackground;

  Color get controlButtonColor => Colors.blue;
  Color get controlButtonSurfaceColor => Colors.black;
  Color get controlLabelColor => Colors.white;

  double get tileRadius;

  DecorationImage? tileImageBackground(int value);

  double get tileSize;
  double get fontSize;
  double get lightTileSize;
  double get lightFontSize;

  String get tileClickSound;

  String tileValue(int value);
}
