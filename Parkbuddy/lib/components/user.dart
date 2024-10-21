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

class Booking {
  final String bookingId;
  final String vehicleId;
  final String parkLotId;
  final DateTime startTime;
  final DateTime endTime;
  final String totalAmount;

  Booking({
    required this.bookingId,
    required this.vehicleId,
    required this.parkLotId,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
  });

  // Factory method to create a Booking instance from a Firestore document
  factory Booking.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Booking(
      bookingId: doc.id, // assuming booking ID is the document ID
      vehicleId: data['vehicle_id'] ?? 'd',
      parkLotId: data['parklot_id'] ?? '',
      startTime: (data['start_time'] as Timestamp).toDate(),
      endTime: (data['end_time'] as Timestamp).toDate(),
      totalAmount: data['total_amount'],
    );
  }
}


class MobileUser {
  final String Username;
  final String Useremail;
  final List<Vehicle> Ownedvehicles;
  final List<Booking> Bookings;

  MobileUser({
    required this.Username,
    required this.Useremail,
    required this.Ownedvehicles,
    required this.Bookings
  });

  factory MobileUser.fromDocument(DocumentSnapshot doc,QuerySnapshot vehicleSnapshot,QuerySnapshot bookingSnapshot) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Vehicle> vehicles = vehicleSnapshot.docs.map((doc) => Vehicle.fromDocument(doc)).toList();
    List<Booking> _bookings = bookingSnapshot.docs.map((doc)=>Booking.fromDocument(doc)).toList();

    return MobileUser(
      Username: data['Username'] ?? '',
      Useremail: data['Useremail'] ?? '',
      Ownedvehicles: vehicles,
      Bookings: _bookings
    );
  }

}
