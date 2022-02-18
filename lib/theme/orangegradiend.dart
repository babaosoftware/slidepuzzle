import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class OrangeGradientTheme extends PuzzleTheme {
  const OrangeGradientTheme() : super();

  @override
  String get name => 'Gradient';

  @override
  Color tileBackColor(int value, int boarSize) {
    if (boarSize == 3) {
      switch (value) {
        case 1:
          return const Color(0xFFCC9900);
        case 2:
          return const Color(0xFFFFE000);
        case 3:
          return const Color(0xFFFFF15F);
        case 4:
          return const Color(0xFF1E2791);
        case 5:
          return const Color(0xFF3364C0);
        case 6:
          return const Color(0xFF4C9ADD);
        case 7:
          return const Color(0xFF80194D);
        case 8:
          return const Color(0xFFB31B81);
        default:
          return const Color(0xFFFFF15F);
      }
    } else {
      switch (value) {
        case 1:
          return const Color(0xFFCC9900);
        case 2:
          return const Color(0xFFFFE000);
        case 3:
          return const Color(0xFFFFF15F);
        case 4:
          return const Color(0xFFFFFF99);
        case 5:
          return const Color(0xFF1E2791);
        case 6:
          return const Color(0xFF3364C0);
        case 7:
          return const Color(0xFF4C9ADD);
        case 8:
          return const Color(0xFF64B6EE);
        case 9:
          return const Color(0xFF80194D);
        case 10:
          return const Color(0xFFB31B81);
        case 11:
          return const Color(0xFFE61CB4);
        case 12:
          return const Color(0xFFFF1DCE);
        case 13:
          return const Color(0xFF094F29);
        case 14:
          return const Color(0xFF1A8828);
        case 15:
          return const Color(0xFF64AD62);
        default:
          return const Color(0xFF94C58C);
      }
    }
  }

  @override
  Color tileBorderColor(int value) => PuzzleColors.transparent;
  @override
  Color tileTextColor(int value) => PuzzleColors.transparent;

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
