import 'package:slidepuzzle/models/target.dart';

enum BoardType {
  basic,
  reverse,
  spiral,
  snake,
}

List<Target> createTargetBoard(int size, BoardType type) {
    List<Target> targets = [];

    switch (type) {
      case BoardType.basic:
        if (size == 3) {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(1, 0));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 2));
          targets.add(const Target(2, 0));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 2));
        } else {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(0, 3));
          targets.add(const Target(1, 0));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 2));
          targets.add(const Target(1, 3));
          targets.add(const Target(2, 0));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 3));
          targets.add(const Target(3, 0));
          targets.add(const Target(3, 1));
          targets.add(const Target(3, 2));
          targets.add(const Target(3, 3));
        }
        break;
      case BoardType.reverse:
        if (size == 3) {
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 0));
          targets.add(const Target(1, 2));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 0));
          targets.add(const Target(0, 2));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 0));
        } else {
          targets.add(const Target(3, 3));
          targets.add(const Target(3, 2));
          targets.add(const Target(3, 1));
          targets.add(const Target(3, 0));
          targets.add(const Target(2, 3));
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 0));
          targets.add(const Target(1, 3));
          targets.add(const Target(1, 2));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 0));
          targets.add(const Target(0, 3));
          targets.add(const Target(0, 2));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 0));
        }
        break;
      case BoardType.spiral:
        if (size == 3) {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(1, 2));
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 0));
          targets.add(const Target(1, 0));
          targets.add(const Target(1, 1));
        } else {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(0, 3));
          targets.add(const Target(1, 3));
          targets.add(const Target(2, 3));
          targets.add(const Target(3, 3));
          targets.add(const Target(3, 2));
          targets.add(const Target(3, 1));
          targets.add(const Target(3, 0));
          targets.add(const Target(2, 0));
          targets.add(const Target(1, 0));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 2));
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 1));
        }
        break;
      case BoardType.snake:
        if (size == 3) {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(1, 2));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 0));
          targets.add(const Target(2, 0));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 2));
        } else {
          targets.add(const Target(0, 0));
          targets.add(const Target(0, 1));
          targets.add(const Target(0, 2));
          targets.add(const Target(0, 3));
          targets.add(const Target(1, 3));
          targets.add(const Target(1, 2));
          targets.add(const Target(1, 1));
          targets.add(const Target(1, 0));
          targets.add(const Target(2, 0));
          targets.add(const Target(2, 1));
          targets.add(const Target(2, 2));
          targets.add(const Target(2, 3));
          targets.add(const Target(3, 3));
          targets.add(const Target(3, 2));
          targets.add(const Target(3, 1));
          targets.add(const Target(3, 0));
        }
        break;
    }
    return targets;
  }
