import 'package:equatable/equatable.dart';
import 'package:slidepuzzle/models/hint.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class NewGame extends GameEvent {
  const NewGame();
}

class InitializeGame extends GameEvent {
  const InitializeGame();
}

class RestartGame extends GameEvent {
  const RestartGame();
}

class TileClick extends GameEvent {
  const TileClick(this.value);

  final int value;
  @override
  List<Object> get props => [value];
}

class AutoPlay extends GameEvent {
  const AutoPlay();
}

class GameHint extends GameEvent {
  const GameHint();
}

class GameHintReceived extends GameEvent {
  const GameHintReceived(this.value);

  final int value;
  @override
  List<Object> get props => [value];
}

class GameBack extends GameEvent {
  const GameBack();
}
