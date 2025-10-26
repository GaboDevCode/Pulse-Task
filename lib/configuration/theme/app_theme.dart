import 'package:flutter/material.dart';

class AppTheme {
  static final List<Color> colors = [
    Colors.blue,

    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    const Color(0xFF7BAEC5), // Gris más definido
  ];

  static ThemeData getTheme(int index) {
    assert(
      index >= 0 && index < colors.length,
      'Index must be between 0 and ${colors.length - 1}',
    );
    return ThemeData(colorSchemeSeed: colors[index], useMaterial3: true);
  }

  static String getColorName(Color color) {
    if (color == Colors.blue) return 'Azul';
    if (color == Colors.red) return 'Rojo';
    if (color == Colors.green) return 'Verde';
    if (color == Colors.yellow) return 'Amarillo';
    if (color == Colors.orange) return 'Naranja';
    if (color == Colors.purple) return 'Morado';
    if (color == Color(0xFF7BAEC5)) return 'Azul claro';

    return 'Personalizado';
  }
}
