import 'package:flutter/material.dart';

Dialog getThemeDialog(BuildContext context, String currentTheme) {
  return Dialog(
    elevation: 0,
    backgroundColor: Colors.lightBlue[100],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: SizedBox(
      height: 400,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Pick a theme',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            createTile(context, 'Default', 'Default', currentTheme),
            createTile(context, 'Orange', 'Orange', currentTheme),
            createTile(context, 'Glow', 'Glow', currentTheme),
            createTile(context, 'Monochrome', 'Monochrome', currentTheme),
            createTile(context, 'Letters', 'Letters', currentTheme),
            createTile(context, 'Gradient', 'Gradient', currentTheme),
          ],
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

int getThemeIndex(String? themeName) {
  var index = 0;
  switch (themeName) {
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
  return index;
}
