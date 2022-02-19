import 'dart:collection';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';

import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/cell.dart';
import 'package:slidepuzzle/models/hint.dart';
import 'package:slidepuzzle/models/saver.dart';
import 'package:slidepuzzle/models/target.dart';
import 'package:slidepuzzle/models/targetboard.dart';

class Game {
  static const int simulationSteps = 10000;

  late List<Target> target;
  late int gameSize;
  late BoardType type;
  late int emptyCellValue;
  late Board gameBoard;
  late Queue<Board> history;
  Random rnd = Random();

  Game(this.type, this.gameSize, {bool newGame = true}) {
    target = createTargetBoard(gameSize, type);
    emptyCellValue = gameSize * gameSize;
    gameBoard = Board(gameSize, target);
    history = Queue<Board>();
    if (newGame) {
      simulateGame();
    }
  }

  Game.copy(Game game) {
    target = game.target;
    gameSize = game.gameSize;
    type = game.type;
    emptyCellValue = game.emptyCellValue;
    gameBoard = Board.copy(game.gameBoard);
    history = game.history;
  }

  // Game.fromBoard(this.type, this.gameSize, this.gameBoard){
  //   target = createTargetBoard(gameSize, type);
  //   emptyCellValue = gameSize * gameSize;
  // }

  Board getGameBoard() {
    return gameBoard;
  }

  List<Target> getTarget() {
    return target;
  }

  simulateGame() {
    int count = 0;
    do {
      List<Cell> cells = findMovableCells(gameBoard);
      int index = rnd.nextInt(cells.length);
      Cell cell = cells[index];
      gameBoard.moveCell(cell.i, cell.j);
      count++;
    } while (count < simulationSteps || checkGameSolved());
  }

  Hint getBoardHint(List<Board> hintStack) {
    Hint hint = getHint(gameBoard, hintStack);
    return hint;
  }

  Hint getHint(Board gameBoard, List<Board>? hintStack) {
    if (checkSolved(gameBoard)) {
      return Hint(emptyCellValue, 0, []);
    }

    Set<String> visited = TreeSet<String>();
    if (null != hintStack) {
      for (var hintEntry in hintStack) {
        visited.add(hintEntry.getKey());
      }
    }

    PriorityQueue<Saver> boards = PriorityQueue<Saver>((a, b) => a.compareTo(b));
    List<Cell> movableCells = findMovableCells(gameBoard);
    for (Cell cell in movableCells) {
      Board newBoard = getNextBoard(cell, gameBoard);
      String boardKey = newBoard.getKey();
      if (!visited.contains(boardKey)) {
        boards.add(Saver(newBoard, null, cell.value, 1));
        visited.add(boardKey);
      }
    }

    // if (addCount == 1) {
    //   Saver lastSaver = boards.removeFirst();
    //   return Hint(lastSaver.value, lastSaver.count);
    // }

    while (true) {
      Saver saver = boards.removeFirst();
      if (checkSolved(saver.board)) {
        List<int> values = [];
        Saver? currentSaver = saver;
        while (currentSaver != null) {
          values.add(currentSaver.value);
          currentSaver = currentSaver.prevSaver;
        }
        debugPrint('values count: ${values.length} boards count: ${boards.length}');
        return Hint(values[values.length - 1], saver.count, values);
      }
      List<Cell> mCells = findMovableCells(saver.board);
      mCells.shuffle();
      for (Cell cell in mCells) {
        Board newBoard = getNextBoard(cell, saver.board);
        String boardKey = newBoard.getKey();
        if (!visited.contains(boardKey)) {
          boards.add(Saver(newBoard, saver, cell.value, saver.count + 1));
          visited.add(boardKey);
        }
      }
    }
  }

  Board getNextBoard(Cell cell, Board gameBoard) {
    Board newBoard = Board.copy(gameBoard);
    newBoard.moveCell(cell.i, cell.j);
    return newBoard;
  }

  List<Cell> findMovableCells(Board gameBoard) {
    return gameBoard.getMovableCells();
  }

  bool moveValue(int value) {
    Board savedBoard = Board.copy(gameBoard);
    bool res = moveCell(value, gameBoard);
    if (res) {
      history.addLast(savedBoard);
    }
    return res;
  }

  bool moveCell(int value, Board gameBoard) {
    return gameBoard.moveValue(value);
  }

  bool moveBack() {
    if (history.isEmpty) {
      return false;
    } else {
      gameBoard = history.removeLast();
      return true;
    }
  }

  void restart() {
    if (history.isNotEmpty) {
      gameBoard = history.last;
      history.clear();
    }
  }

  bool canGoBack() {
    return history.isNotEmpty;
  }

  int backSteps() {
    return history.length;
  }

  bool checkSolved(Board gameBoard) {
    return gameBoard.isSolved();
  }

  bool checkGameSolved() {
    return checkSolved(gameBoard);
  }

  @override
  String toString() {
    return gameBoard.toString();
  }
}
