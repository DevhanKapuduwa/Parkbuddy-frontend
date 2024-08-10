import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle{
  final String number;
  final String brand;
  final String type;

  Vehicle({
    required this.number,
    required this.brand,
    required this.type
  });

  factory Vehicle.fromMap(Map<String, String> data) {
    return Vehicle(
      number: data['number'] ?? '',
      brand: data['brand'] ?? '',
      type: data['type'] ?? '',
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

  factory MobileUser.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var vehicles = data['vehicles'] as List<dynamic>? ?? [];
    List<Vehicle> ownedVehiclesList = vehicles.map((vehicleData) {
      return Vehicle.fromMap(vehicleData as Map<String, String>);
    }).toList();

    return MobileUser(
      Username: data['Username'] ?? '',
      Useremail: data['Useremail'] ?? '',
      Ownedvehicles: ownedVehiclesList,
    );
  }

}
