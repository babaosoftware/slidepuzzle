import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/theme/puzzletheme.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themes,
    required this.theme,
    this.sound = true,
  });

  /// The list of all available themes.
  final List<PuzzleTheme> themes;

  /// Currently selected theme.
  final PuzzleTheme theme;

  final bool sound;

  @override
  List<Object> get props => [themes, theme, sound];

  ThemeState copyWith({
    List<PuzzleTheme>? themes,
    PuzzleTheme? theme,
    bool? sound,
  }) {
    return ThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
      sound: sound ?? this.sound,
    );
  }
}
