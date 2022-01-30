import 'dart:async';

import 'package:flutter/material.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/hint.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/state/cubit.dart';
import 'package:slidepuzzle/widgets/controlpanel.dart';
import 'package:slidepuzzle/widgets/tileboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sliding Puzzle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Board> _hintStack = [];
  final Game _game = Game(BoardType.snake, 4);
  late Board _currentBoard;
  late Board _prevBoard;
  late Hint hint;

  void _autoPlay() {
    if (!autoPlayCubit.state) return;
    hint = _game.getBoardHint(_hintStack);
    _game.moveValue(hint.value);
    if (!_game.checkGameSolved()) {
      Timer(const Duration(milliseconds: 500), () {
        _autoPlay();
      });
    }
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _prevBoard = Board.copy(_currentBoard);
        _currentBoard = Board.copy(_game.getGameBoard());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _currentBoard = Board.copy(_game.getGameBoard());
    _prevBoard = Board.copy(_game.getGameBoard());
    autoPlayCubit.stream.listen((autoPlay) {
      if (autoPlay) _autoPlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TileBoard(
              _currentBoard,
              _prevBoard,
            ),
            const ControlPanel(),
          ],
        ),
      ),
    );
  }
}
