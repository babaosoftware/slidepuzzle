import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/game.dart';
import 'package:slidepuzzle/models/hint.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/pages/startpage.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/controlbloc.dart';
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
      home: const StartPage(),
    );
  }
}

