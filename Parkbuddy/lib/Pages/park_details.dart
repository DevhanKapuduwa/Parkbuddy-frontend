import 'package:flutter/material.dart';
import 'package:plz/components/user.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'notifications.dart';
import 'profile.dart';
import 'shop.dart';

class ParkDetailsPage extends StatefulWidget {
  final Park park;
  final MobileUser current_User;

  ParkDetailsPage({super.key, required this.park, required this.current_User});

  @override
  State<ParkDetailsPage> createState() => _ParkDetailsPageState();
}

class _ParkDetailsPageState extends State<ParkDetailsPage> {
  var _selectedTime = TimeOfDay.now();

  var _selectedDate = DateTime.now();

  void selecttime() {
    Future<void> _selectTime(BuildContext context) async {
      var picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );
      if (picked != null && picked != _selectedTime) {
        setState(() {
          _selectedTime = picked;
        });
      }
    }

    _selectTime(context);
  }

  void selectDate() {
    Future<void> _selectdate(BuildContext context) async {
      var picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    }

    _selectdate(context);
  }

  int quantityCount = 0;
  String dropdownValue = "00 : 00 A.M.";

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void addToCart() {
    if (quantityCount > 0) {
      // final homepage=context.read<HomePage>();
      Park current_park = widget.park;
      print("Park ID:");
      print(current_park.id);
      print("User id:");
      print(widget.current_User.Useremail);

      final shop = context.read<Shop>();
      DateTime parsedDate = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _selectedTime.hour, _selectedTime.minute);

      shop.addToCart(
          widget.park, quantityCount, parsedDate, widget.current_User);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            // Define the selected vehicle as a variable outside the StatefulBuilder so that it can be updated and passed to other widgets
            String selectedVehicle = "Car"; // Default selected vehicle

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Colors.orangeAccent,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Select your vehicle:",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildVehicleTile(
                            setState,
                            selectedVehicle,
                            "Car",
                            Icons.directions_car,
                            (vehicleType) => selectedVehicle =
                                vehicleType, // Update the selected vehicle
                          ),
                          _buildVehicleTile(
                            setState,
                            selectedVehicle,
                            "Van",
                            Icons.airport_shuttle,
                            (vehicleType) => selectedVehicle = vehicleType,
                          ),
                          _buildVehicleTile(
                            setState,
                            selectedVehicle,
                            "Motorbike",
                            Icons.motorcycle,
                            (vehicleType) => selectedVehicle = vehicleType,
                          ),
                          _buildVehicleTile(
                            setState,
                            selectedVehicle,
                            "Bus",
                            Icons.directions_bus,
                            (vehicleType) => selectedVehicle = vehicleType,
                          ),
                          _buildVehicleTile(
                            setState,
                            selectedVehicle,
                            "Jeep",
                            Icons.directions_ferry_outlined,
                            (vehicleType) => selectedVehicle = vehicleType,
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Close the dialog without adding
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        showConfirmationDialog(
                            selectedVehicle); // Pass the selected vehicle to the confirmation dialog
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      }
    }
  }

  Widget _buildVehicleTile(
    StateSetter setState,
    String selectedVehicle,
    String vehicleType,
    IconData icon,
    Function(String)
        onVehicleSelected, // Add callback to update the selected vehicle
  ) {
    bool isSelected = selectedVehicle == vehicleType;
    return GestureDetector(
      onTap: () {
        setState(() {
          onVehicleSelected(
              vehicleType); // Update the selected vehicle via callback
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 40, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(height: 5),
            Text(
              vehicleType,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(String vehicle) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "Successfully added to cart for your $vehicle",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close both dialogs and go back
            },
            icon: Icon(
              Icons.done,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Mobile user::");
    print(this.widget.current_User.Useremail);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.park.name,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
                child: Icon(Icons.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications())),
                child: Icon(Icons.notifications)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              Current_User: this.widget.current_User,
                            ))),
                child: Icon(Icons.person)),
            label: '',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  Image.asset(widget.park.imagePath),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 5, height: 5),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(width: 5, height: 5),
                      Text(
                        widget.park.rating,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(height: 2),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      widget.park.extension,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(height: 2),
                  SizedBox(height: 5),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10), // Adjust the height as needed
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.park.description,
                          style: TextStyle(
                              fontSize: 16), // Adjust text style as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade500,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.only(top: 15, bottom: 25, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reservation Date : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: selectDate,
                        child: Text(
                          "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.02),
                            padding: EdgeInsets.symmetric(horizontal: 48))),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reservation Time : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: selecttime,
                        child: Text(
                          _selectedTime.format(context),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.02),
                            padding: EdgeInsets.symmetric(horizontal: 57))),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs. " + widget.park.price + " / hr            :",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            onPressed: decrementQuantity,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              quantityCount.toString() + " hrs",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: incrementQuantity,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total pay                : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                    ]),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.2), // Text color
                  ),
                  onPressed: addToCart,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Book Now",
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        "Rs. ${quantityCount * int.parse(widget.park.price)}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
