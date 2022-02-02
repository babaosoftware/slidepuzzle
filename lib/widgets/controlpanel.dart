import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/state/controlbloc.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autoPlay = context.select((AutoPlayCubit bloc) => bloc.state);
    final counter = context.select((GameCounterCubit bloc) => bloc.state);

    return MultiBlocListener(
        listeners: [
          BlocListener<AutoPlayCubit, bool>(listener: (context, state) {
            // if (theme.hasTimer && state.puzzleStatus == PuzzleStatus.complete) {
            //   context.read<TimerBloc>().add(const TimerStopped());
            // }
          }),
          BlocListener<GameCounterCubit, int>(listener: (context, state) {
            // if (theme.hasTimer && state.puzzleStatus == PuzzleStatus.complete) {
            //   context.read<TimerBloc>().add(const TimerStopped());
            // }
          }),
        ],
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: autoPlay
                        ? null
                        : () {
                            context.read<NewGameCubit>().newGame();
                          },
                    child: const Text("New Game")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: autoPlay
                        ? null
                        : () {
                            context.read<RestartGameCubit>().restartGame();
                          },
                    child: const Text("Restart")),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: autoPlay ? null : () {
                  context.read<HintCubit>().hint();
                }, child: const Text("Hint")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: autoPlay ? null : () {}, child: const Text("Back")),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      context.read<AutoPlayCubit>().flip();
                    },
                    child: Text(autoPlay ? "Stop" : "Auto Play")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {}, child: Text('Steps: $counter')),
              ),
            ]),
          ],
        ));
  }
}
