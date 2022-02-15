import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// The currently selected theme has changed.
class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeIndex});

  /// The index of the newly selected theme from [ThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
