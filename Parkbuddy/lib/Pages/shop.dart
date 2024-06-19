import 'package:flutter/material.dart';

class Park {
  final String imagePath;
  final String name;
  final String price;
  final String rating;
  final String description;
  final String extension;

  Park({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.extension,
  });
}

class Shop extends ChangeNotifier {
  final List<Park> _bookNowParks = [
    Park(
      imagePath: 'lib/images/ogf.jpg',
      name: 'OGF',
      price: '100',
      rating: '4.5',
      description:
          'Prime Location: Located in the heart of downtown, perfect for business and shopping.\nSecure & Spacious: 24/7 security and ample space for all vehicle sizes.',
      extension: 'One Galle Face Mall',
    ),
    Park(
      imagePath: 'lib/images/kcc.jpg',
      name: 'KCC',
      price: '200',
      rating: '4.7',
      description:
          'Eco-Friendly: Equipped with EV charging stations and green energy solutions.\nConvenient Access: Close to public transit and major highways for easy commuting.',
      extension: 'Kandy City Centre',
    ),
    Park(
      imagePath: 'lib/images/ccc.jpg',
      name: 'CCC',
      price: '100',
      rating: '5.0',
      description:
          'Affordable Rates: Competitive pricing with various discount options for regular users.\nFamily-Friendly: Special spaces for families and stroller access throughout.',
      extension: 'Colombo City Centre',
    ),
  ];

  Map<String, Map<String, dynamic>> _cart = {};

  List<Park> get bookNowParks => _bookNowParks;

  Map<String, Map<String, dynamic>> get cart => _cart;

  void addToCart(Park park, int quantity, String reservationTime) {
    final key = '${park.name}_$reservationTime';
    if (_cart.containsKey(key)) {
      _cart[key]!['quantity'] += quantity;
    } else {
      _cart[key] = {
        'park': park,
        'quantity': quantity,
        'time': reservationTime
      };
    }
    notifyListeners();
  }

  void removeFromCart(String key) {
    _cart.remove(key);
    notifyListeners();
  }
}
