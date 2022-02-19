import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/pages/gamepage.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/widgets/themedialog.dart';
import 'package:slidepuzzle/widgets/tileboardlight.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? currentTheme = "Classic";

  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return BlocProvider.value(
      value: themeBloc,
      child: Scaffold(
          backgroundColor: themeBloc.state.theme.pageBackground,
          appBar: null,
          body: Stack(children: [
            Positioned(
              left: 0,
              right: 0,
              top: 80,
              bottom: 0,
              child: SingleChildScrollView(
                child: smallScreen ? oneColumnTable() : twoColumnTable(),
              ),
            ),
            Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.tune,
                          color: Colors.transparent,
                        )),
                    Expanded(
                        child: Center(
                            child: Text(
                          'Pick a board',
                          style: TextStyle(color: themeBloc.state.theme.controlLabelColor, fontSize: 36),
                        )),
                        flex: 1),
                    IconButton(
                        color: themeBloc.state.theme.controlLabelColor,
                        onPressed: () async {
                          String? newTheme = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return getThemeDialog(context, themeBloc.state.theme.name);
                              });
                          if (null != newTheme) {
                            setState(() {
                              currentTheme = newTheme;
                            });
                            themeBloc.add(ThemeChanged(themeIndex: getThemeIndex(currentTheme ?? "")));
                          }
                        },
                        icon: const Icon(Icons.tune)),
                  ],
                ))
          ])),
    );
  }

  Widget startCell(String title, BoardType boardType, int boardSize) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: BlocProvider.value(
              value: themeBloc,
              child: Text(
                title,
                style: TextStyle(color: themeBloc.state.theme.controlLabelColor, fontSize: 16),
              ),
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
    return Center(
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(300),
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
      ),
    );
  }
}
