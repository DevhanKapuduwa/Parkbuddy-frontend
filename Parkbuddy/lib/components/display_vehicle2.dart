// import 'package:flutter/material.dart';
//
// import '../components/user.dart';
//
// class DisplayVehicles2 extends StatefulWidget {
//   final MobileUser currentUser;
//   final String selectedVehicleType; // Add this to accept the selected type
//
//   const DisplayVehicles2({
//     super.key,
//     required this.currentUser,
//     required this.selectedVehicleType,
//   });
//
//   @override
//   _DisplayVehiclesState createState() => _DisplayVehiclesState();
// }
//
// class _DisplayVehiclesState extends State<DisplayVehicles2> {
//   @override
//   Widget build(BuildContext context) {
//     // Filter the list based on the selected vehicle type
//     List<Vehicle> filteredVehicles = widget.currentUser.Ownedvehicles
//         .where((vehicle) => vehicle.type == widget.selectedVehicleType)
//         .toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.selectedVehicleType} Vehicles'),
//       ),
//       body: Container(
//         child: filteredVehicles.isNotEmpty
//             ? ListView.builder(
//                 itemCount: filteredVehicles.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(filteredVehicles[index].number),
//                   subtitle: Text(
//                       "${filteredVehicles[index].brand} - ${filteredVehicles[index].type}"),
//                   leading: Icon(_getVehicleIcon(filteredVehicles[index].type)),
//                 ),
//               )
//             : Center(
//                 child: Text("No ${widget.selectedVehicleType} vehicles found"),
//               ),
//       ),
//     );
//   }
//
//   // Helper function to return the appropriate icon based on vehicle type
//   IconData _getVehicleIcon(String type) {
//     switch (type) {
//       case "Car":
//         return Icons.directions_car;
//       case "Van":
//         return Icons.airport_shuttle;
//       case "Motorbike":
//         return Icons.motorcycle;
//       case "Bus":
//         return Icons.directions_bus;
//       case "Jeep":
//         return Icons.directions_ferry_outlined;
//       default:
//         return Icons.directions_car; // Default icon
//     }
//   }
// }

import 'package:flutter/material.dart';

import '../components/user.dart';

class DisplayVehicles2 extends StatefulWidget {
  final MobileUser currentUser;
  final String selectedVehicleType; // Add this to accept the selected type

  const DisplayVehicles2({
    super.key,
    required this.currentUser,
    required this.selectedVehicleType,
  });

  @override
  _DisplayVehiclesState createState() => _DisplayVehiclesState();
}

class _DisplayVehiclesState extends State<DisplayVehicles2> {
  Vehicle? selectedVehicle; // Store the selected vehicle

  @override
  Widget build(BuildContext context) {
    // Filter the list based on the selected vehicle type
    List<Vehicle> filteredVehicles = widget.currentUser.Ownedvehicles
        .where((vehicle) => vehicle.type == widget.selectedVehicleType)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedVehicleType} Vehicles'),
      ),
      body: Column(
        children: [
          // Vehicle list
          Expanded(
            child: filteredVehicles.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredVehicles.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(filteredVehicles[index].number),
                      subtitle: Text(
                          "${filteredVehicles[index].brand} - ${filteredVehicles[index].type}"),
                      leading:
                          Icon(_getVehicleIcon(filteredVehicles[index].type)),
                      onTap: () {
                        setState(() {
                          // Set the selected vehicle
                          selectedVehicle = filteredVehicles[index];
                        });
                      },
                      tileColor: selectedVehicle == filteredVehicles[index]
                          ? Colors.orangeAccent.withOpacity(0.3)
                          : null, // Highlight selected item
                    ),
                  )
                : Center(
                    child:
                        Text("No ${widget.selectedVehicleType} vehicles found"),
                  ),
          ),
          // Select button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedVehicle == null
                  ? null // Disable if no vehicle is selected
                  : () {
                      // Show success message
                      _showSuccessDialog();
                    },
              child: Text("Select"),
            ),
          ),
        ],
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

  // Function to show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must acknowledge the dialog
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Successfully added to bookings"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
