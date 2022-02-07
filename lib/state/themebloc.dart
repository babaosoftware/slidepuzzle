import 'package:bloc/bloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/theme/blackwhite.dart';
import 'package:slidepuzzle/theme/default.dart';
import 'package:slidepuzzle/theme/letters.dart';
import 'package:slidepuzzle/theme/puzzle.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required List<PuzzleTheme> initialThemes})
      : super(ThemeState(themes: initialThemes, theme: initialThemes[0])) {
    on<ThemeChanged>(_onThemeChanged);
    // on<ThemeUpdated>(_onThemeUpdated);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }

  // void _onThemeUpdated(ThemeUpdated event, Emitter<ThemeState> emit) {
  //   final themeIndex =
  //       state.themes.indexWhere((theme) => theme.name == event.theme.name);

  //   if (themeIndex != -1) {
  //     final newThemes = [...state.themes];
  //     newThemes[themeIndex] = event.theme;
  //     emit(
  //       state.copyWith(
  //         themes: newThemes,
  //         theme: event.theme,
  //       ),
  //     );
  //   }
  // }
}

final themeBloc = ThemeBloc(initialThemes: [const BlackWhiteTheme(), const DefaultTheme(), const LettersTheme()]);

