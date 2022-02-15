import 'package:bloc/bloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/theme/blackwhite.dart';
import 'package:slidepuzzle/theme/default.dart';
import 'package:slidepuzzle/theme/glow.dart';
import 'package:slidepuzzle/theme/letters.dart';
import 'package:slidepuzzle/theme/orangegradiend.dart';
import 'package:slidepuzzle/theme/puzzle.dart';
import 'package:slidepuzzle/theme/wood.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required List<PuzzleTheme> initialThemes})
      : super(ThemeState(themes: initialThemes, theme: initialThemes[0])) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}

final themeBloc = ThemeBloc(initialThemes: [const DefaultTheme(), const WoodTheme(), const GlowTheme(), const BlackWhiteTheme(), const LettersTheme(), const OrangeGradientTheme(),]);

