import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/colors/colors.dart';
import 'package:slidepuzzle/state/gamebloc.dart';
import 'package:slidepuzzle/state/gameevent.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';
import 'package:slidepuzzle/typography/text_styles.dart';

class Tile extends StatelessWidget {
  const Tile(this.value, this.isEmpty, {this.light = false, Key? key}) : super(key: key);

  final int value;
  final bool isEmpty;
  final bool light;
  static final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          width: light ? state.theme.lightTileSize : state.theme.tileSize,
          height: light ? state.theme.lightTileSize : state.theme.tileSize,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                image: isEmpty ? null : state.theme.tileImageBackground(value),
                color: isEmpty ? PuzzleColors.transparent : (value.isEven ? state.theme.evenTileBackColor : state.theme.oddTileBackColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(state.theme.tileRadius),
                ),
                border: isEmpty
                    ? const Border()
                    : Border(
                        top: BorderSide(width: 2.0, color: state.theme.oddTileBorderColor),
                        left: BorderSide(width: 2.0, color: state.theme.oddTileBorderColor),
                        right: BorderSide(width: 2.0, color: state.theme.oddTileBorderColor),
                        bottom: BorderSide(width: 2.0, color: state.theme.oddTileBorderColor),
                      ),
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: const Color(0x10FFFF00),
                  disabledMouseCursor: light ? SystemMouseCursors.click : SystemMouseCursors.basic,
                  enabledMouseCursor: light ? SystemMouseCursors.click : SystemMouseCursors.click,
                  textStyle: PuzzleTextStyle.headline2.copyWith(
                    fontSize: light ? state.theme.lightFontSize : state.theme.fontSize,
                    // color: const Color(0x10FF00FF),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ).copyWith(
                  // foregroundColor: MaterialStateProperty.all(value.isEven ? state.theme.evenTileTextColor : state.theme.oddTileTextColor),
                  backgroundColor: MaterialStateProperty.all(
                      isEmpty ? PuzzleColors.transparent : (value.isEven ? state.theme.evenTileBackColor : state.theme.oddTileBackColor)),
                ),
                onPressed: light || isEmpty
                    ? null
                    : () {
                        player.play(state.theme.tileClickSound);
                        context.read<GameBloc>().add(TileClick(value));
                      },
                child: Text(isEmpty ? '' : state.theme.tileValue(value), style: TextStyle(color: value.isEven ? state.theme.evenTileTextColor : state.theme.oddTileTextColor)),
              ),
            ),
          ),
        );
      }
    );
  }

}
