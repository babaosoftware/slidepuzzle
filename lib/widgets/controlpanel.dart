import 'package:flutter/material.dart';
import 'package:slidepuzzle/state/cubit.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  bool autoPlay = autoPlayCubit.state;

  @override
  void initState() {
    super.initState();
    autoPlayCubit.stream.listen((autoPlay) {
      setState(() {
        this.autoPlay = autoPlay;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("New Game")),
        ElevatedButton(onPressed: () {}, child: const Text("Hint")),
        ElevatedButton(
            onPressed: () {
              autoPlayCubit.flip();
            },
            child: Text(autoPlay ? "Stop" : "Auto Play")),
        ElevatedButton(onPressed: () {}, child: const Text("Back")),
        ElevatedButton(onPressed: () {}, child: const Text("Restart")),
      ],
    );
  }
}
