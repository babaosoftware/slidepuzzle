import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themes,
    required this.theme,
  });

  /// The list of all available themes.
  final List<PuzzleTheme> themes;

  /// Currently selected theme.
  final PuzzleTheme theme;

  @override
  List<Object> get props => [themes, theme];

  ThemeState copyWith({
    List<PuzzleTheme>? themes,
    PuzzleTheme? theme,
  }) {
    return ThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
