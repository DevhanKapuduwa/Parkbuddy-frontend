import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddvehicleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to upload image to Firebase Storage
  Future<String> uploadImage(String userEmail, Uint8List file) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('vehicles')
          .child(userEmail)
          .child(DateTime.now().toString()); // Unique filename

      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }

  // Method to add vehicle details to Firestore
  Future<void> addVehicleDetails(String userEmail, String registrationNumber,
      String brand, String type, String imageUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(userEmail)
          .collection('vehicles')
          .add({
        'registrationNumber': registrationNumber,
        'brand': brand,
        'type': type,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      throw Exception("Failed to add vehicle: $e");
    }
  }
}
