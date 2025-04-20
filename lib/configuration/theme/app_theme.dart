import 'package:flutter/material.dart';

class AppTheme {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.teal,
  ];

  ThemeData selectColor(int index) {
    assert(
      index >= 0 && index < colors.length,
      'Index must be between 0 and ${colors.length - 1}',
    );
    return ThemeData(colorSchemeSeed: colors[index]);
  }
}
