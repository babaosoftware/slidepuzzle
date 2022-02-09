import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/sizes/tilesize.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';

class ControlPanelArena extends StatefulWidget {
  const ControlPanelArena({Key? key}) : super(key: key);

  @override
  _ControlPanelArenaState createState() => _ControlPanelArenaState();
}

class _ControlPanelArenaState extends State<ControlPanelArena> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final smallScreen = MediaQuery.of(context).size.width <= PuzzleBreakpoints.small;

    return Padding(
      padding: smallScreen ? const EdgeInsets.only(top: 16.0) : const EdgeInsets.only(left: 16.0),
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 300), child: buildTable()),
    );
  }

  Widget buildTable() {
    final state = context.select((GameBloc bloc) => bloc.state);
    final counter = state.counter;
    final gameEnd = state.boardState == BoardState.end;
    final autoPlay = state.autoPlay;
    final initialized = state.initialized;
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          buildPanelButton("New Game", !initialized || autoPlay ? null : () => context.read<GameBloc>().add(const NewGame())),
          buildPanelButton("Restart", !initialized || autoPlay || counter <= 0 ? null : () => context.read<GameBloc>().add(const RestartGame())),
        ]),
        TableRow(children: [
          buildPanelButton("Back", !initialized || autoPlay || counter <= 0 ? null : () => context.read<GameBloc>().add(const GameBack())),
          Padding(
            padding: const EdgeInsets.only(left: 48.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Text('Steps: ${state.counter}', style: const TextStyle(color: PuzzleColors.textColor)),
          ),
        ]),
      ],
    );
  }

  Widget buildPanelButton(String text, void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(style: ElevatedButton.styleFrom(disabledMouseCursor: SystemMouseCursors.basic), onPressed: onPressed, child: Text(text)),
    );
  }
}
