import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  File? _profileImage;

  File? get profileImage => _profileImage;

  ProfileProvider() {
    _loadImage();
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
    notifyListeners();
  }
}
