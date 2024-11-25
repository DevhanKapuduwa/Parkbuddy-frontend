// import 'package:flutter/material.dart';
//
// import '../components/user.dart';
//
// class SelectVehiclePage extends StatelessWidget {
//   final List<Vehicle> vehicles;
//
//   SelectVehiclePage({super.key, required this.vehicles});
//
//   @override
//   Widget build(BuildContext context) {
//     String? selectedVehicle; // To hold the selected vehicle
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Your Vehicle'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Select Vehicle",
//               ),
//               value: selectedVehicle,
//               onChanged: (value) {
//                 selectedVehicle = value!;
//               },
//               items: vehicles.map((vehicle) {
//                 return DropdownMenuItem(
//                   value: vehicle.number,
//                   child: Text(
//                       "${vehicle.number} - ${vehicle.brand} (${vehicle.type})"),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedVehicle != null) {
//                   // Navigate or perform further actions with the selected vehicle
//                   print("Selected Vehicle: $selectedVehicle");
//                   Navigator.pop(context); // Close the page or navigate further
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please select a vehicle')),
//                   );
//                 }
//               },
//               child: Text('Confirm'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Vehicle {
  final String number;
  final String type;
  final String brand;

  Vehicle({required this.number, required this.type, required this.brand});
}

class SelectVehiclePage extends StatelessWidget {
  final List<Vehicle> vehicles;

  SelectVehiclePage({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Vehicle"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select Vehicle",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Vehicle>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Vehicle",
                ),
                items: vehicles.map((vehicle) {
                  return DropdownMenuItem<Vehicle>(
                    value: vehicle,
                    child: Text(
                        "${vehicle.type} - ${vehicle.brand} (${vehicle.number})"),
                  );
                }).toList(),
                onChanged: (Vehicle? selectedVehicle) {
                  if (selectedVehicle != null) {
                    // Handle selected vehicle
                    print(
                        "Selected: ${selectedVehicle.type}, ${selectedVehicle.brand}, ${selectedVehicle.number}");
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add action to confirm selection
                  Navigator.pop(context); // Go back after selection
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
