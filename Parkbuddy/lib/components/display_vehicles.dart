// import 'package:flutter/material.dart';
//
// import '../components/user.dart';
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
//   @override
//   Widget build(BuildContext context) {
//     List<Vehicle> Vehicle_list = widget.currentUser.Ownedvehicles;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Registered Vehicles'),
//         ),
//         body: Container(
//           child: widget.currentUser.Ownedvehicles.isNotEmpty
//               ? ListView.builder(
//                   itemCount: Vehicle_list.length,
//                   itemBuilder: (context, index) => ListTile(
//                         title: Text(Vehicle_list[index].number),
//                         subtitle: Text(
//                             "${Vehicle_list[index].brand} - ${Vehicle_list[index].type}"),
//                         leading: Icon(Icons.directions_car),
//                       ))
//               : Text("data"),
//         ));
//   }
// }

import 'package:flutter/material.dart';

import '../components/user.dart';

class DisplayVehicles extends StatefulWidget {
  final MobileUser currentUser;

  const DisplayVehicles({super.key, required this.currentUser});

  @override
  _DisplayVehiclesState createState() => _DisplayVehiclesState();
}

class _DisplayVehiclesState extends State<DisplayVehicles> {
  @override
  Widget build(BuildContext context) {
    List<Vehicle> Vehicle_list = widget.currentUser.Ownedvehicles;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Vehicles'),
      ),
      body: Container(
        child: widget.currentUser.Ownedvehicles.isNotEmpty
            ? ListView.builder(
                itemCount: Vehicle_list.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(Vehicle_list[index].number),
                  subtitle: Text(
                      "${Vehicle_list[index].brand} - ${Vehicle_list[index].type}"),
                  leading: Icon(_getVehicleIcon(Vehicle_list[index].type)),
                ),
              )
            : Center(child: Text("No registered vehicles found")),
      ),
    );
  }

// Helper function to return the appropriate icon based on vehicle type
  IconData _getVehicleIcon(String type) {
    switch (type) {
      case "Car":
        return Icons.directions_car;
      case "Van":
        return Icons.airport_shuttle;
      case "Motorbike":
        return Icons.motorcycle;
      case "Bus":
        return Icons.directions_bus;
      case "Jeep":
        return Icons.directions_ferry_outlined;
      default:
        return Icons.directions_car; // Default icon
    }
  }
}
