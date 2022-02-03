import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class NewGame extends GameEvent {
  const NewGame();
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
