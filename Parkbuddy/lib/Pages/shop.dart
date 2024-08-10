
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/components/connect_firebase.dart';



class Park {
  final String imagePath;
  final String name;
  final String price;
  final String rating;
  final String description;
  final String extension;
  final String id;

  Park({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.extension,
    required this.id
  });

  factory Park.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Park(
        imagePath:data['imagepath']?? "lib/images/default.jpg",
        name: data['Car_park_name'] ?? 'No name',
        price: data['Prize'] ?? '400',
        rating: data['Rating'] ?? "3",
        description: data['Description'] ?? "No description",
        extension: data['Extension']?? data["Car_park_name"] ?? "no name",
        id: doc.id
    );
  }
}


getparks() async{
  print("Getting parks");
  var available_parks=await getParks();
  // var currentcarpark=await getuser();
  // var newpark=Park(imagePath: 'lib/images/default.jpg', name: currentcarpark["Car_park_name"], price: '400', rating: "4/5", description: 'good', extension: currentcarpark["User_name"],id: "bandu@gmail.com");
  // var available_parks=[
  //   Park(
  //     imagePath: 'lib/images/ogf.jpg',
  //     name: 'OGF',
  //     price: '100',
  //     rating: '4.5',
  //     description:
  //     'Prime Location: Located in the heart of downtown, perfect for business and shopping.\nSecure & Spacious: 24/7 security and ample space for all vehicle sizes.',
  //     extension: 'One Galle Face Mall',
  //     id:"ds"
  //   ),
  //   Park(
  //     imagePath: 'lib/images/kcc.jpg',
  //     name: 'KCC',
  //     price: '200',
  //     rating: '4.7',
  //     description:
  //     'Eco-Friendly: Equipped with EV charging stations and green energy solutions.\nConvenient Access: Close to public transit and major highways for easy commuting.',
  //     extension: 'Kandy City Centre',
  //       id:"ds"
  //   ),
  //   Park(
  //     imagePath: 'lib/images/ccc.jpg',
  //     name: 'CCC',
  //     price: '100',
  //     rating: '5.0',
  //     description:
  //     'Affordable Rates: Competitive pricing with various discount options for regular users.\nFamily-Friendly: Special spaces for families and stroller access throughout.',
  //     extension: 'Colombo City Centre',
  //       id:"ds"
  //   ),
  //   newpark
  // ];
  return available_parks;
}

class Shop extends ChangeNotifier {




  List<Park> _bookNowParks =[
    Park(
        imagePath: 'lib/images/ogf.jpg',
        name: 'OGF',
        price: '100',
        rating: '4.5',
        description:
        'Prime Location: Located in the heart of downtown, perfect for business and shopping.\nSecure & Spacious: 24/7 security and ample space for all vehicle sizes.',
        extension: 'One Galle Face Mall',
        id:"ds"
    ),
    Park(
        imagePath: 'lib/images/kcc.jpg',
        name: 'KCC',
        price: '200',
        rating: '4.7',
        description:
        'Eco-Friendly: Equipped with EV charging stations and green energy solutions.\nConvenient Access: Close to public transit and major highways for easy commuting.',
        extension: 'Kandy City Centre',
        id:"ds"
    ),
    Park(
        imagePath: 'lib/images/ccc.jpg',
        name: 'CCC',
        price: '100',
        rating: '5.0',
        description:
        'Affordable Rates: Competitive pricing with various discount options for regular users.\nFamily-Friendly: Special spaces for families and stroller access throughout.',
        extension: 'Colombo City Centre',
        id:"ds"
    ),
  ];

  Map<String, Map<String, dynamic>> _cart = {};

  List<Park> get bookNowParks => _bookNowParks;

  Map<String, Map<String, dynamic>> get cart => _cart;

  void addToCart(Park park, int quantity, DateTime parsedDate) {



    // print("Parks");print(park.id);print("quean");print(quantity);print(parsedDate.toString());
    notifyListeners();
  }

  void removeFromCart(String key) {
    _cart.remove(key);
    notifyListeners();
  }
}
