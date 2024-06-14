import 'package:flutter/material.dart';

import 'homepage.dart';

class Shop extends ChangeNotifier{
  final List<Park> _bookNowParks = [
    Park(
      imagePath: 'lib/images/ogf.jpg',
      name: 'OGF',
      price: '100',
      rating: '4.5',
      description: 'Prime Location: Located in the heart of downtown, perfect for business and shopping.\nSecure & Spacious: 24/7 security and ample space for all vehicle sizes.',
    ),
    Park(
      imagePath: 'lib/images/kcc.jpg',
      name: 'KCC',
      price: '200',
      rating: '4.7',
      description: 'Eco-Friendly: Equipped with EV charging stations and green energy solutions.\nConvenient Access: Close to public transit and major highways for easy commuting.',
    ),
    Park(
      imagePath: 'lib/images/ccc.jpg',
      name: 'CCC',
      price: '100',
      rating: '5.0',
      description: 'Affordable Rates: Competitive pricing with various discount options for regular users.\nFamily-Friendly: Special spaces for families and stroller access throughout.',
    ),

  ];

  List<Park> _cart =[];

  List<Park> get  bookNowParks => _bookNowParks;
  List<Park> get  cart => _cart;


  void addToCart(Park parkItem, int rounds) {
    for(int i=0;i<rounds;i++) {
      _cart.add(parkItem);
    }
    notifyListeners();
  }

  void removeFromCart(Park parkpoint) {
    _cart.remove(parkpoint);
    notifyListeners();
  }

}