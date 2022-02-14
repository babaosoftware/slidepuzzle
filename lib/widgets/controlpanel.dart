import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/layouts/breakpoints.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {

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
    final themeState = context.select((ThemeBloc bloc) => bloc.state);
    final counter = state.counter;
    final gameEnd = state.boardState == BoardState.end;
    final isHint = state.boardState == BoardState.hint;
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
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Text(gameEnd? 'Game over!' : '', style: TextStyle(color: themeState.theme.controlLabelColor, fontSize: 20)),
          ),
          Container(),
        ]),
        TableRow(children: [
          buildPanelButton("New Game", !initialized || autoPlay ? null : () => context.read<GameBloc>().add(const NewGame())),
          buildPanelButton("Restart", !initialized || autoPlay || counter <= 0 ? null : () => context.read<GameBloc>().add(const RestartGame())),
        ]),
        TableRow(children: [
          buildPanelButton("Hint", !initialized || autoPlay || gameEnd || state.boardSize > 4 ? null : () => context.read<GameBloc>().add(const GameHint()), showSpinner: isHint),
          buildPanelButton("Back", !initialized || autoPlay || counter <= 0 ? null : () => context.read<GameBloc>().add(const GameBack())),
        ]),
        TableRow(children: [
          buildPanelButton(
              autoPlay ? "Stop" : "Auto Play", !initialized || gameEnd || state.boardSize > 4 ? null : () => context.read<GameBloc>().add(const AutoPlay())),
          Padding(
            padding: const EdgeInsets.only(left: 48.0, top: 8.0, bottom: 8.0, right: 8.0),
            child: Text('Steps: ${state.counter}', style: TextStyle(color: themeState.theme.controlLabelColor)),
          ),
        ]),
      ],
    );
  }

  Widget buildPanelButton(String text, void Function()? onPressed, {showSpinner = false}) {
    final themeState = context.select((ThemeBloc bloc) => bloc.state);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: themeState.theme.controlButtonColor,
                onSurface: themeState.theme.controlButtonSurfaceColor, disabledMouseCursor: SystemMouseCursors.basic),
            onPressed: onPressed,
            child: showSpinner ? const SizedBox(width:16, height: 16, child: CircularProgressIndicator(color: Colors.white)) : Text(text)),
      );
  }
}
