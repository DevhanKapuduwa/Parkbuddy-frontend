import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String imageUrl;
  final String number;
  final String brand;
  final String type;

  Vehicle({
    required this.imageUrl,
    required this.number,
    required this.brand,
    required this.type,
  });

  // Factory method to create a Vehicle instance from a Firestore document
  factory Vehicle.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Vehicle(

      brand: data['brand'] ?? '', // replace with correct field names
      imageUrl: data['imageUrl'] ?? '',
      number: data['number'] ?? '',
      type: data['type'] ?? ''
    );
  }
}

class MobileUser {
  final String Username;
  final String Useremail;
  final List<Vehicle> Ownedvehicles;

  MobileUser({
    required this.Username,
    required this.Useremail,
    required this.Ownedvehicles
  });

  factory MobileUser.fromDocument(DocumentSnapshot doc,QuerySnapshot vehicleSnapshot) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Vehicle> vehicles = vehicleSnapshot.docs.map((doc) => Vehicle.fromDocument(doc)).toList();

    return MobileUser(
      Username: data['Username'] ?? '',
      Useremail: data['Useremail'] ?? '',
      Ownedvehicles: vehicles,
    );
  }

}
