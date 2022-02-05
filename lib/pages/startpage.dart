import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidepuzzle/colors/colors.dart';
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
    // final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return Scaffold(
        backgroundColor: PuzzleColors.gameBack,
        appBar: AppBar(
          title: const Text("8/15 Puzzle"),
        ),
        body: ListView(children: [
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "3x3 Horizontal", boardType: BoardType.basic, boardSize: 3)));
          }, child: TileBoardLight(Board(3, createTargetBoard(3, BoardType.basic)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "3x3 Reverse", boardType: BoardType.reverse, boardSize: 3)));
          }, child: TileBoardLight(Board(3, createTargetBoard(3, BoardType.reverse)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "3x3 Spiral", boardType: BoardType.spiral, boardSize: 3)));
          }, child: TileBoardLight(Board(3, createTargetBoard(3, BoardType.spiral)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "3x3 Snake", boardType: BoardType.snake, boardSize: 3)));
          }, child: TileBoardLight(Board(3, createTargetBoard(3, BoardType.snake)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "4x4 Horizontal", boardType: BoardType.basic, boardSize: 4)));
          }, child: TileBoardLight(Board(4, createTargetBoard(4, BoardType.basic)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "4x4 Reverse", boardType: BoardType.reverse, boardSize: 4)));
          }, child: TileBoardLight(Board(4, createTargetBoard(4, BoardType.reverse)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "4x4 Spiral", boardType: BoardType.spiral, boardSize: 4)));
          }, child: TileBoardLight(Board(4, createTargetBoard(4, BoardType.spiral)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "4x4 Snake", boardType: BoardType.snake, boardSize: 4)));
          }, child: TileBoardLight(Board(4, createTargetBoard(4, BoardType.snake)))),
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage(title: "5x5 Horizontal", boardType: BoardType.basic, boardSize: 5)));
          }, child: TileBoardLight(Board(5, createTargetBoard(5, BoardType.basic)))),
        ],));
  }
}
