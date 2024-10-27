
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/components/connect_firebase.dart';
import 'package:http/http.dart' as http;
import 'package:plz/components/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Park {
  final String imagePath;
  final String name;
  final String price;
  final String rating;
  final String description;
  final String extension;
  final String id;
  final GeoPoint location; // Added location property

  Park({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
    required this.extension,
    required this.id,
    required this.location, // Include location in constructor
  });

  factory Park.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Park(
      imagePath: data['imagepath'] ?? "lib/images/default.jpg",
      name: data['Car_park_name'] ?? 'No name',
      price: data['Prize'] ?? '400',
      rating: data['Rating'] ?? "3",
      description: data['Description'] ?? "No description",
      extension: data['Extension'] ?? data["Car_park_name"] ?? "no name",
      id: doc.id,
      location: data['location'] ?? GeoPoint(0, 0), // Retrieve location or default
    );
  }
  void printDetails() {
    print('Image Path: $imagePath');
    print('Name: $name');
    print('Price: $price');
    print('Rating: $rating');
    print('Description: $description');
    print('Extension: $extension');
    print('ID: $id');
    print('Location: Latitude ${location.latitude}, Longitude ${location.longitude}');
  }
}


// class Park {
//   final String imagePath;
//   final String name;
//   final String price;
//   final String rating;
//   final String description;
//   final String extension;
//   final String id;
//
//   Park({
//     required this.imagePath,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.description,
//     required this.extension,
//     required this.id
//   });
//
//   factory Park.fromDocument(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Park(
//         imagePath:data['imagepath']?? "lib/images/default.jpg",
//         name: data['Car_park_name'] ?? 'No name',
//         price: data['Prize'] ?? '400',
//         rating: data['Rating'] ?? "3",
//         description: data['Description'] ?? "No description",
//         extension: data['Extension']?? data["Car_park_name"] ?? "no name",
//         id: doc.id
//     );
//   }
// }


getparks() async{
  print("Getting parks");
  var available_parks=await getParks();
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
        id:"ds",
      location: GeoPoint(6.927330501335749, 79.844653479797)
    ),
    Park(
        imagePath: 'lib/images/kcc.jpg',
        name: 'KCC',
        price: '200',
        rating: '4.7',
        description:
        'Eco-Friendly: Equipped with EV charging stations and green energy solutions.\nConvenient Access: Close to public transit and major highways for easy commuting.',
        extension: 'Kandy City Centre',
        id:"ds",
        location: GeoPoint(7.292277702139469, 80.6370718798007)
    ),
    Park(
        imagePath: 'lib/images/ccc.jpg',
        name: 'CCC',
        price: '100',
        rating: '5.0',
        description:
        'Affordable Rates: Competitive pricing with various discount options for regular users.\nFamily-Friendly: Special spaces for families and stroller access throughout.',
        extension: 'Colombo City Centre',
        id:"ds",
        location: GeoPoint(6.917547106356931, 79.85492520678427)
    ),
  ];

  Map<String, Map<String, dynamic>> _cart = {};

  List<Park> get bookNowParks => _bookNowParks;

  Map<String, Map<String, dynamic>> get cart => _cart;




  Future<void> addToCart(Park park, int quantity, DateTime StartTime,MobileUser Cur_user) async {
    DateTime EndTime = StartTime.add(Duration(hours: quantity));
    Booking _booking = Booking(bookingId: "bookingId", vehicleId: "vehicleId", parkLotId: park.id, startTime: StartTime, endTime: EndTime, totalAmount: quantity.toString(), parkName: park.name);

    String? response=await addBookingToFirestore(_booking, Cur_user);//response is id of booking



    var cartItem={
      'start':StartTime.toString(),
      'end':EndTime.toString(),
      'Vehicle':"Car",
      'title':Cur_user.Username,
      'Vehicle_number':"VAL 1890",
      'Car_park':park.id,
    };

    if(response==null){

    }

    try {

      const url =  'https://tm659tws-8000.asse.devtunnels.ms/'; // Replace with your actual URL
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(cartItem),

      );
      print("New response::${response.body}");
    } catch (e){
      print('An error occurred: $e');
    }

    notifyListeners();
  }

  void removeFromCart(String key) {
    _cart.remove(key);
    notifyListeners();
  }
}
