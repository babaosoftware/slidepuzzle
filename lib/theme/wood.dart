import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class WoodTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const WoodTheme() : super();

  @override
  String get name => 'BlackWhite';

  @override
  Color get evenTileBackColor => PuzzleColors.transparent;
  @override
  Color get oddTileBackColor => PuzzleColors.transparent;

  @override
  Color get evenTileBorderColor => PuzzleColors.transparent;
  @override
  Color get oddTileBorderColor => PuzzleColors.transparent;

  @override
  Color get evenTileTextColor => PuzzleColors.white;
  @override
  Color get oddTileTextColor => PuzzleColors.white;

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
  DecorationImage? tileImageBackground(int value) => const DecorationImage(image: AssetImage("images/woodtile.png"), fit: BoxFit.cover);

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
