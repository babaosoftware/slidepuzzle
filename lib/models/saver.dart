import 'package:slidepuzzle/models/board.dart';

class Saver {
  final Board board;
  final int value;
  int count = 0;
  int heuristic = 0;

  Saver(this.board, this.value, this.count) {
    heuristic = board.getManhattanDistance() + count;
  }

  Saver.copy(this.board, this.value);

  int compareTo(Saver s) {
    return heuristic - s.heuristic;
  }
}
