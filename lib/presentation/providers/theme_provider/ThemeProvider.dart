import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex; // resiviendo getter

  void setColorIndex(int index) {
    _selectedColorIndex = index;
    notifyListeners();
  }
}
