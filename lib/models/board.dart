import 'package:slidepuzzle/models/target.dart';

import 'cell.dart';

enum BoardKey { left, right, up, down }

class Board {
  late List<List<int>> board;
  late int size;
  late int emptyCellValue;
  late List<int> valuesi;
  late List<int> valuesj;
  late String key;
  late List<Target> target;

  Board(this.size, this.target) {
    emptyCellValue = size * size;
    board = List.generate(size, (index) => List.generate(size, (index) => 0));
    valuesi = List.generate(emptyCellValue, (index) => 0);
    valuesj = List.generate(emptyCellValue, (index) => 0);
    for (int i = 0; i < size * size; i++) {
      Target targetCell = target[i];
      board[targetCell.i][targetCell.j] = i + 1;
      valuesi[i] = targetCell.i;
      valuesj[i] = targetCell.j;
    }
    calculateKey();
  }

  Board.copy(Board board) {
    target = board.target;
    size = board.size;
    emptyCellValue = size * size;
    this.board = List.generate(size, (index) => List.generate(size, (index) => 0));
    valuesi = List.generate(emptyCellValue, (index) => 0);
    valuesj = List.generate(emptyCellValue, (index) => 0);
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        this.board[i][j] = board.board[i][j];
        valuesi[this.board[i][j] - 1] = i;
        valuesj[this.board[i][j] - 1] = j;
      }
    }
    calculateKey();
  }

  int getEmptyCellValue() {
    return emptyCellValue;
  }

  Cell findCell(int value) {
    return Cell(valuesi[value - 1], valuesj[value - 1], value);
  }

  int getKeyValue(BoardKey key) {
    int emptyi = valuesi[emptyCellValue - 1];
    int emptyj = valuesj[emptyCellValue - 1];

    switch (key) {
      case BoardKey.left:
        return (emptyj < size - 1) ? board[emptyi][emptyj + 1] : -1;
      case BoardKey.right:
        return (emptyj > 0) ? board[emptyi][emptyj - 1] : -1;
      case BoardKey.up:
        return (emptyi < size - 1) ? board[emptyi + 1][emptyj] : -1;
      case BoardKey.down:
        return (emptyi > 0) ? board[emptyi - 1][emptyj] : -1;
    }
  }

  List<Cell> getMovableCells() {
    List<Cell> cells = [];
    int emptyi = valuesi[emptyCellValue - 1];
    int emptyj = valuesj[emptyCellValue - 1];
    if (emptyi > 0) cells.add(Cell(emptyi - 1, emptyj, board[emptyi - 1][emptyj])); // cell on top of empty
    if (emptyi < size - 1) cells.add(Cell(emptyi + 1, emptyj, board[emptyi + 1][emptyj])); // cell beneath of empty
    if (emptyj > 0) cells.add(Cell(emptyi, emptyj - 1, board[emptyi][emptyj - 1])); // cell to the left of empty
    if (emptyj < size - 1) cells.add(Cell(emptyi, emptyj + 1, board[emptyi][emptyj + 1])); // cell to the right of empty
    return cells;
  }

  bool isSolved() {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        Target targetCell = target[board[i][j] - 1];
        if (targetCell.i != i || targetCell.j != j) return false;
      }
    }
    return true;
  }

  bool canMove(int value) {
    List<Cell> movable = getMovableCells();
    for (int i = 0; i < movable.length; i++) {
      if (movable[i].value == value) return true;
    }
    return false;
  }

  bool moveCell(int i, int j) {
    int emptyi = valuesi[emptyCellValue - 1];
    int emptyj = valuesj[emptyCellValue - 1];
    if (j == emptyj) {
      if (i == emptyi - 1) {
        board[i + 1][j] = board[i][j];
        valuesi[board[i + 1][j] - 1] = i + 1;
        valuesj[board[i + 1][j] - 1] = j;
        board[i][j] = emptyCellValue;
        valuesi[board[i][j] - 1] = i;
        valuesj[board[i][j] - 1] = j;
        calculateKey();
        return true;
      }
      if (i == emptyi + 1) {
        board[i - 1][j] = board[i][j];
        valuesi[board[i - 1][j] - 1] = i - 1;
        valuesj[board[i - 1][j] - 1] = j;
        board[i][j] = emptyCellValue;
        valuesi[board[i][j] - 1] = i;
        valuesj[board[i][j] - 1] = j;
        calculateKey();
        return true;
      }
    }
    if (i == emptyi) {
      if (j == emptyj - 1) {
        board[i][j + 1] = board[i][j];
        valuesi[board[i][j + 1] - 1] = i;
        valuesj[board[i][j + 1] - 1] = j + 1;
        board[i][j] = emptyCellValue;
        valuesi[board[i][j] - 1] = i;
        valuesj[board[i][j] - 1] = j;
        calculateKey();
        return true;
      }
      if (j == emptyj + 1) {
        board[i][j - 1] = board[i][j];
        valuesi[board[i][j - 1] - 1] = i;
        valuesj[board[i][j - 1] - 1] = j - 1;
        board[i][j] = emptyCellValue;
        valuesi[board[i][j] - 1] = i;
        valuesj[board[i][j] - 1] = j;
        calculateKey();
        return true;
      }
    }
    return false;
  }

  bool moveValue(int value) {
    Cell cell = findCell(value);
    return moveCell(cell.i, cell.j);
  }

  int getManhattanDistance() {
    int count = 0;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        int value = board[i][j];
        Target targetCell = target[value - 1];
        count += ((i - targetCell.i).abs() + (j - targetCell.j).abs()) * (size == 3 ? 1 : (size));
      }
    }
    return count;
  }

  void calculateKey() {
    key = "";
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] < 10) {
          key += "0";
        }
        key += board[i][j].toString();
      }
    }
  }

  String getKey() {
    return key;
  }

  @override
  String toString() {
    String str = "";
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == emptyCellValue) {
          str += " xx";
        } else if (board[i][j] < 10) {
          str += " 0" + board[i][j].toString();
        } else {
          str += " " + board[i][j].toString();
        }
      }
      str += "\n";
    }
    return str;
  }
}
