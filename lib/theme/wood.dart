import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class WoodTheme extends PuzzleTheme {
  const WoodTheme() : super();

  @override
  String get name => 'Orange';

  @override
  Color tileBackColor(int value) => PuzzleColors.transparent;
  @override
  Color tileBorderColor(int value) => PuzzleColors.transparent;
  @override
  Color tileTextColor(int value) => PuzzleColors.white;

  @override
  Color get boardBackColor => const Color(0xC0FFA726);
  @override
  Color get boardBorderColor => const Color(0xFFFF9100);

  @override
  Color get pageBackground => Colors.grey.shade800;

  @override
  Color get controlButtonColor => const Color(0xFFFF9800);
  @override
  Color get controlButtonSurfaceColor => Colors.orange;
  @override
  Color get controlLabelColor => Colors.orange;

  @override
  double get tileRadius => 12.0;

  @override
  DecorationImage? tileImageBackground(int value) => const DecorationImage(image: AssetImage("assets/images/woodtile.png"), fit: BoxFit.cover);

  @override
  double get tileSize => 70;
  @override
  double get fontSize => 25;
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
