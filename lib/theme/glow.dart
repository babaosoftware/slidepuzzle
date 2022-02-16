import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class GlowTheme extends PuzzleTheme {
  const GlowTheme() : super();

  @override
  String get name => 'Glow';

  @override
  Color tileBackColor(int value) => PuzzleColors.transparent;
  @override
  Color tileBorderColor(int value) => PuzzleColors.transparent;
  @override
  Color tileTextColor(int value) => value.isEven ? PuzzleColors.orange : PuzzleColors.blue;

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
  DecorationImage? tileImageBackground(int value) => DecorationImage(image: AssetImage(value.isEven ? "assets/images/gloworange.png" : "assets/images/glowblue.png"), fit: BoxFit.cover);

  @override
  double get fontSize => 25;
  
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


