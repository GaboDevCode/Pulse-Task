import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pulse_task/presentation/widgets/InterstitialAdManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  File? _profileImage;
  int _profileChangue = 0;
  final InterstitialAdManager _adManager = InterstitialAdManager();

  File? get profileImage => _profileImage;
  int get changeCount => _profileChangue; // Útil para debug

  ProfileProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadImage();
    _adManager.loadInterstitialAd(); // Cargar anuncio después de inicializar
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');
    if (path != null && File(path).existsSync()) {
      _profileImage = File(path);
      notifyListeners();
    }
  }

  Future<void> setProfileImage(File image) async {
    _profileImage = image;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', image.path);
    _handleProfileChange();
    notifyListeners();
  }

  void _handleProfileChange() {
    _profileChangue++;
    if (_profileChangue == 1) {
      _adManager.showInterstitial().then((shown) {
        if (shown) {
          _adManager.showInterstitial();
        }
      });
    }
  }
}
