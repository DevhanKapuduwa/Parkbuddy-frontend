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
    List<Vehicle> Vehicle_list=widget.currentUser.Ownedvehicles;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Vehicles'),
      ),
      body: Container(
        child: widget.currentUser.Ownedvehicles.isNotEmpty? 
        ListView.builder(
          itemCount: Vehicle_list.length,
            itemBuilder: (context,index)=>
            ListTile(
              title: Text(Vehicle_list[index].number),
                subtitle: Text(Vehicle_list[index].brand),
                leading: Icon(Icons.directions_car),
            )
        ):Text("data"),
      )
    );


  }
}
