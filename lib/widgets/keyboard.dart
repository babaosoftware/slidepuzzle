import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/models/board.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/gamestate.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themeevent.dart';

class PuzzleKeyboardHandler extends StatefulWidget {
  const PuzzleKeyboardHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State createState() => _PuzzleKeyboardHandlerState();
}

class _PuzzleKeyboardHandlerState extends State<PuzzleKeyboardHandler> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    final boardState = context.read<GameBloc>().state.boardState;
    final board = context.read<GameBloc>().state.currentBoard;

    if (event is RawKeyDownEvent && (boardState == BoardState.ongoing || boardState == BoardState.start)) {
      final physicalKey = event.data.physicalKey;

      int? value;
      if (physicalKey == PhysicalKeyboardKey.arrowDown) {
        value = board.getKeyValue(BoardKey.down);
      } else if (physicalKey == PhysicalKeyboardKey.arrowUp) {
        value = board.getKeyValue(BoardKey.up);
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        value = board.getKeyValue(BoardKey.right);
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        value = board.getKeyValue(BoardKey.left);
      }

      if (value != null && value != -1) {
        context.read<ThemeBloc>().add(const ThemePlay());
        context.read<GameBloc>().add(TileClick(value));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Builder(
        builder: (context) {
          if (!_focusNode.hasFocus) {
            FocusScope.of(context).requestFocus(_focusNode);
          }
          return widget.child;
        },
      ),
    );
  }
}
