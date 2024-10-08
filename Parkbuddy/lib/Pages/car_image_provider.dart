import 'dart:typed_data';

import 'package:flutter/material.dart';

class CarImageProvider with ChangeNotifier {
  Uint8List? _carImage;

  Uint8List? get carImage => _carImage;

  void updateCarImage(Uint8List? newImage) {
    _carImage = newImage;
    notifyListeners();
  }
}
