import 'package:flutter/material.dart';
import 'package:slidepuzzle/state/themebloc.dart';

Dialog getThemeDialog(BuildContext context, String currentTheme) {
  return Dialog(
    elevation: 0,
    backgroundColor: Colors.lightBlue[100],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Pick a theme',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              ...themeBloc.state.themes.map((theme) => createTile(context, theme.name, theme.name, currentTheme)).toList(),
            ],
          ),
        ),
      ),
    ),
  );
}

RadioListTile<String> createTile(BuildContext context, String title, String value, String groupValue) {
  return RadioListTile<String>(
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    value: value,
    groupValue: groupValue,
    onChanged: (String? value) {
      Navigator.of(context).pop(value);
    },
  );
}

int getThemeIndex(String themeName) {
  return themeBloc.state.themes.map((theme) => theme.name).toList().indexOf(themeName);
}
