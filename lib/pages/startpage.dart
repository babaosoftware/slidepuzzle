import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/pages/gamepage.dart';
import 'package:slidepuzzle/widgets/tileboardlight.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return Scaffold(
        backgroundColor: PuzzleColors.gameBack,
        appBar: AppBar(
          title: const Text("Pick a game board"),
        ),
        body: SingleChildScrollView(
          child: smallScreen ? oneColumnTable() : twoColumnTable(),
        ));
  }

  Widget startCell(String title, BoardType boardType, int boardSize) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              title,
              style: const TextStyle(color: PuzzleColors.white, fontSize: 16),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(title: title, boardType: boardType, boardSize: boardSize)));
              },
              child: TileBoardLight(Board(boardSize, createTargetBoard(boardSize, boardType)))),
        ],
      ),
    ));
  }

  Widget oneColumnTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          startCell("3x3 Horizontal", BoardType.basic, 3),
        ]),
        TableRow(children: [
          startCell("3x3 Reverse", BoardType.reverse, 3),
        ]),
        TableRow(children: [
          startCell("3x3 Spiral", BoardType.spiral, 3),
        ]),
        TableRow(children: [
          startCell("3x3 Snake", BoardType.snake, 3),
        ]),
        TableRow(children: [
          startCell("4x4 Horizontal", BoardType.basic, 4),
        ]),
        TableRow(children: [
          startCell("4x4 Reverse", BoardType.reverse, 4),
        ]),
        TableRow(children: [
          startCell("4x4 Spiral", BoardType.spiral, 4),
        ]),
        TableRow(children: [
          startCell("4x4 Snake", BoardType.snake, 4),
        ]),
      ],
    );
  }

  Widget twoColumnTable() {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          startCell("3x3 Horizontal", BoardType.basic, 3),
          startCell("3x3 Reverse", BoardType.reverse, 3),
        ]),
        TableRow(children: [
          startCell("3x3 Spiral", BoardType.spiral, 3),
          startCell("3x3 Snake", BoardType.snake, 3),
        ]),
        TableRow(children: [
          startCell("4x4 Horizontal", BoardType.basic, 4),
          startCell("4x4 Reverse", BoardType.reverse, 4),
        ]),
        TableRow(children: [
          startCell("4x4 Spiral", BoardType.spiral, 4),
          startCell("4x4 Snake", BoardType.snake, 4),
        ]),
      ],
    );
  }
}
