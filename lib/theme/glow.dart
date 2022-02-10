import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class GlowTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const GlowTheme() : super();

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
  Color get evenTileTextColor => PuzzleColors.orange;
  @override
  Color get oddTileTextColor => PuzzleColors.blue;

  @override
  Color get boardBackColor => PuzzleColors.black;
  @override
  Color get boardBorderColor => PuzzleColors.grey1;

  @override
  Color get pageBackground => PuzzleColors.black;

  @override
  Color get controlButtonColor => const Color(0xFFFF9800);
  @override
  Color get controlButtonSurfaceColor => Colors.orange;
  @override
  Color get controlLabelColor => Colors.orange;



  @override
  double get tileRadius => 16.0;

  @override
  DecorationImage? tileImageBackground(int value) => DecorationImage(image: AssetImage(value.isEven ? "images/gloworange.png" : "images/glowblue.png"), fit: BoxFit.cover);

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


