import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/models/targetboard.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';
import 'package:slidepuzzle/widgets/controlpanel.dart';
import 'package:slidepuzzle/widgets/tileboard.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title, required this.boardType, required this.boardSize}) : super(key: key);
  final String title;
  final BoardType boardType;
  final int boardSize;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameBloc gameBloc;
  late bool sound;

  @override
  void initState() {
    gameBloc = GameBloc(widget.boardType, widget.boardSize);
    sound = themeBloc.state.sound;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;
    return Scaffold(
        backgroundColor: themeBloc.state.theme.pageBackground,
        appBar: null,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => gameBloc),
            BlocProvider.value(value: themeBloc),
          ],
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: smallScreen
                    ? Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets())
                    : Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: buildWidgets()),
              ),
            ),
            Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: themeBloc.state.theme.controlLabelColor,
                    ),
                    Expanded(
                        child: Center(
                            child: Text(
                          widget.title,
                          style: TextStyle(color: themeBloc.state.theme.controlLabelColor, fontSize: 30),
                        )),
                        flex: 1),
                    // ThemeButton(themeBloc.state.theme.name, (index, newTheme) {
                    //   themeBloc.add(ThemeChanged(themeIndex: index));
                    // })
                    IconButton(
                        color: themeBloc.state.theme.controlLabelColor,
                        onPressed: () {
                          themeBloc.add(const ThemeSound());
                          setState(() {
                            sound = !sound;
                          });
                        },
                        icon: Icon(sound ? Icons.volume_up : Icons.volume_off)),
                  ],
                ))
          ]),
        ));
  }

  List<Widget> buildWidgets() {
    return [
      const TileBoard(),
      const ControlPanel(),
    ];
  }
}
