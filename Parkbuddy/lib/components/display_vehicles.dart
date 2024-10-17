// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../components/user.dart'; // Assuming this contains the MobileUser class
//
// class DisplayVehicles extends StatefulWidget {
//   final MobileUser currentUser;
//
//   const DisplayVehicles({super.key, required this.currentUser});
//
//   @override
//   _DisplayVehiclesState createState() => _DisplayVehiclesState();
// }
//
// class _DisplayVehiclesState extends State<DisplayVehicles> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registered Vehicles'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('users')
//             .doc(widget.currentUser
//                 .Useremail) // Ensure this matches the path in addVehicleDetails
//             .collection('vehicles')
//             .orderBy('createdAt', descending: true) // Ordering by timestamp
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           // Add logging to see what the snapshot contains
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             print('Loading data...');
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           if (snapshot.hasError) {
//             print('Error: ${snapshot.error}');
//             return Center(
//               child: Text('Error fetching vehicles: ${snapshot.error}'),
//             );
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             print('No vehicles found');
//             return Center(
//               child: Text('No vehicles registered yet.'),
//             );
//           }
//
//           // Print the fetched data for debugging
//           print('Fetched vehicles: ${snapshot.data!.docs.length}');
//           snapshot.data!.docs.forEach((doc) {
//             print('Vehicle: ${doc['registrationNumber']}');
//           });
//
//           // Display the list of vehicles
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot vehicle = snapshot.data!.docs[index];
//               return ListTile(
//                 title: Text(vehicle['registrationNumber']),
//                 subtitle:
//                     Text(vehicle['brand']), // Optional: display vehicle brand
//                 leading: Icon(Icons.directions_car),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../components/user.dart'; // Assuming this contains the MobileUser class
//
// class DisplayVehicles extends StatefulWidget {
//   final MobileUser currentUser;
//
//   const DisplayVehicles({super.key, required this.currentUser});
//
//   @override
//   _DisplayVehiclesState createState() => _DisplayVehiclesState();
// }
//
// class _DisplayVehiclesState extends State<DisplayVehicles> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registered Vehicles'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.currentUser
//                 .Useremail) // Ensure this matches the path in addVehicleDetails
//             .collection('vehicles')
//             .orderBy('createdAt', descending: true) // Ordering by timestamp
//             .snapshots(),
//         builder: (context, snapshot) {
//           List<Row> vehicleWidgets = [];
//           if (snapshot.hasData) {
//             final vehicles = snapshot.data?.docs.reversed.toList();
//             for (var vehicle in vehicles!) {
//               final vehicleWidget = Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     vehicle['number'],
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   Text(vehicle['type']),
//                   Text(vehicle['brand']),
//                 ],
//               );
//               vehicleWidgets.add(vehicleWidget);
//             }
//           }
//           return Expanded(
//             child: ListView(
//               children: vehicleWidgets,
//             ),
//           );
//
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/user.dart';

class DisplayVehicles extends StatefulWidget {
  final MobileUser currentUser;

  const DisplayVehicles({super.key, required this.currentUser});

  @override
  _DisplayVehiclesState createState() => _DisplayVehiclesState();
}

class _DisplayVehiclesState extends State<DisplayVehicles> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Vehicles'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(widget.currentUser.Useremail)
            .collection('vehicles')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(
              child: Text('Error fetching vehicles: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print('No vehicles found for ${widget.currentUser.Useremail}');
            return Center(
              child: Text('No vehicles registered yet.'),
            );
          }

          print('Fetched ${snapshot.data!.docs.length} vehicles');
          snapshot.data!.docs.forEach((doc) {
            print('Vehicle: ${doc['registrationNumber']}');
          });

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot vehicle = snapshot.data!.docs[index];
              return ListTile(
                title: Text(vehicle['registrationNumber']),
                subtitle: Text(vehicle['brand']),
                leading: Icon(Icons.directions_car),
              );
            },
          );
        },
      ),
    );
  }
}
