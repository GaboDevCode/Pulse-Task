import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprovider extends ChangeNotifier {
  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;

  Themeprovider() {
    _loadColorIndex(); // Cargar al iniciar
  }

  void setColorIndex(int index) async {
    _selectedColorIndex = index;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_color_index', index); // Guardar persistente
  }

  Future<void> _loadColorIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('theme_color_index');
    if (savedIndex != null && savedIndex >= 0) {
      _selectedColorIndex = savedIndex;
      notifyListeners();
    }
  }
}
