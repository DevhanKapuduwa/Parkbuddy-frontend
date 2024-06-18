import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfileImageProvider with ChangeNotifier {
  Uint8List? _profileImage;

  Uint8List? get profileImage => _profileImage;

  void updateProfileImage(Uint8List? newImage) {
    _profileImage = newImage;
    notifyListeners();
  }
}
