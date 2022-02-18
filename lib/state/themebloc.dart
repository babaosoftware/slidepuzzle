import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/theme/monochrometheme.dart';
import 'package:slidepuzzle/theme/classictheme.dart';
import 'package:slidepuzzle/theme/glowtheme.dart';
import 'package:slidepuzzle/theme/letterstheme.dart';
import 'package:slidepuzzle/theme/gradienttheme.dart';
import 'package:slidepuzzle/theme/puzzletheme.dart';
import 'package:slidepuzzle/theme/orangetheme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late AudioCache playerCache;
  late AudioPlayer player;

  ThemeBloc({required List<PuzzleTheme> initialThemes}) : super(ThemeState(themes: initialThemes, theme: initialThemes[0])) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemePlay>(_onPlay);
    on<ThemeSound>(_onSound);

    player = AudioPlayer();
    playerCache = AudioCache(fixedPlayer: player);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }

  void _onPlay(ThemePlay event, Emitter<ThemeState> emit) {
    if (state.sound) {
      playerCache.play(state.theme.tileClickSound);
    }
  }

  void _onSound(ThemeSound event, Emitter<ThemeState> emit) {
    emit(state.copyWith(sound: !state.sound));
  }
}

final themeBloc = ThemeBloc(initialThemes: [
  const ClassicTheme(),
  const OrangeTheme(),
  const GlowTheme(),
  const MonochromeTheme(),
  const LettersTheme(),
  const GradientTheme(),
]);
