import 'package:slidepuzzle/models/board.dart';

class Saver {
  final Board board;
  final Saver? prevSaver;
  final int value;
  int count = 0;
  int heuristic = 0;

  Saver(this.board, this.prevSaver, this.value, this.count) {
    heuristic = board.getManhattanDistance() + count;
  }

  Saver.copy(this.board, this.prevSaver, this.value);

  int compareTo(Saver s) {
    return heuristic - s.heuristic;
  }
}
