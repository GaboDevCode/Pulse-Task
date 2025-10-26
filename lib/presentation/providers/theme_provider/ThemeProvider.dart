// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pulse_task/presentation/widgets/InterstitialAdManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprovider extends ChangeNotifier {
  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;
  final InterstitialAdManager _adManager = InterstitialAdManager();

  Themeprovider() {
    _loadColorIndex();
    _adManager.loadInterstitialAd();
  }

  void setColorIndex(int index) async {
    _selectedColorIndex = index;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_color_index', index); //
    _handleColorTheme();
  }

  Future<void> _loadColorIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('theme_color_index');
    if (savedIndex != null && savedIndex >= 0) {
      _selectedColorIndex = savedIndex;
      notifyListeners();
    }
  }

  Future<void> _handleColorTheme() async {
    try {
      final shown = await _adManager.showInterstitial();
      if (!shown) {
        _adManager.showInterstitial();
      }
    } catch (e) {
      debugPrint('Error al mostrar anuncio: $e');
      _adManager.showInterstitial();
    }
  }
}
