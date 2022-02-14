import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidepuzzle/state/themebloc.dart';
import 'package:slidepuzzle/state/themestate.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton(this.onChanged, {Key? key}) : super(key: key);
  final void Function(int, String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return DropdownButton<String>(
        isDense: true,
        value: state.theme.name,
        icon: const Icon(Icons.tune),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (String? newValue) {
          var index = 0;
          switch (newValue) {
            case 'Default':
              index = 0;
              break;
            case 'Orange':
              index = 1;
              break;
            case 'Glow':
              index = 2;
              break;
            case 'Monochrome':
              index = 3;
              break;
            case 'Letters':
              index = 4;
              break;
            case 'Gradient':
              index = 5;
              break;
          }
          onChanged(index, newValue);
        },
        items: <String>['Default', 'Orange', 'Glow', 'Monochrome', 'Letters', 'Gradient'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
