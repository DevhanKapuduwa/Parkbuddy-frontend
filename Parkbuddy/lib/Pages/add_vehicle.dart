// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:plz/Pages/car_image_provider.dart';
// import 'package:plz/Pages/utils.dart';
// import 'package:plz/components/user.dart';
// import 'package:provider/provider.dart';
//
// import 'homepage.dart';
// import 'notifications.dart';
// import 'profile.dart';
//
// class AddVehicle extends StatefulWidget {
//   final MobileUser currentuser;
//   const AddVehicle({super.key, required this.currentuser});
//
//   @override
//   _AddVehicleState createState() => _AddVehicleState();
// }
//
// class _AddVehicleState extends State<AddVehicle> {
//   void selectImage() async {
//     Uint8List? img = await pickImage(ImageSource.gallery);
//     if (img != null) {
//       context.read<CarImageProvider>().updateCarImage(img);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final carImageProvider = context.watch<CarImageProvider>();
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => HomePage())),
//           icon: Icon(LineAwesomeIcons.angle_left_solid),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Add a Vehicle',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomePage())),
//                 child: Icon(Icons.home)),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Notifications())),
//                 child: Icon(Icons.notifications)),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Profile(
//                               Current_User: this.widget.currentuser,
//                             ))),
//                 child: Icon(Icons.person)),
//             label: '',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     carImageProvider.carImage != null
//                         ? CircleAvatar(
//                             radius: 64,
//                             backgroundImage:
//                                 MemoryImage(carImageProvider.carImage!),
//                           )
//                         : SizedBox(
//                             width: 300,
//                             height: 300,
//                             child: ClipRRect(
//                               //  borderRadius: BorderRadius.circular(100),
//                               child: Image(
//                                 image: AssetImage('lib/images/car.jpg'),
//                               ),
//                             ),
//                           ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: selectImage,
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: Colors.orange.withOpacity(0.9),
//                           ),
//                           child: Icon(
//                             LineAwesomeIcons.camera_solid,
//                             size: 30,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Form(
//                     child: Column(
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                           label: Text(
//                             'Registration Number',
//                           ),
//                           prefixIcon: Icon(LineAwesomeIcons.car_alt_solid),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10))),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     SizedBox(
//                       width: 200,
//                       child: ElevatedButton(
//                           onPressed: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => AddVehicle(
//                                       currentuser: this.widget.currentuser))),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange,
//                               side: BorderSide.none,
//                               shape: StadiumBorder()),
//                           child: Text(
//                             'Save Vehicle',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ],
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:plz/Pages/utils.dart';
// import 'package:plz/components/addvehicle_service.dart';
// import 'package:plz/components/user.dart';
//
// import 'homepage.dart';
// import 'notifications.dart';
// import 'profile.dart';
//
// class AddVehicle extends StatefulWidget {
//   final MobileUser currentuser;
//   const AddVehicle({super.key, required this.currentuser});
//
//   @override
//   _AddVehicleState createState() => _AddVehicleState();
// }
//
// class _AddVehicleState extends State<AddVehicle> {
//   final _registrationNumberController = TextEditingController();
//   final _brandController = TextEditingController();
//   final _typeController = TextEditingController();
//   final AddvehicleService _databaseService = AddvehicleService();
//   Uint8List? _vehicleImage;
//
//   // Method to select image and update the state
//   void selectImage() async {
//     Uint8List? img = await pickImage(ImageSource.gallery);
//     if (img != null) {
//       setState(() {
//         _vehicleImage = img;
//       });
//     }
//   }
//
//   // Method to save vehicle details in Firestore
//   void saveVehicle() async {
//     if (_registrationNumberController.text.isEmpty ||
//         _brandController.text.isEmpty ||
//         _typeController.text.isEmpty ||
//         _vehicleImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please fill all fields and select an image.")),
//       );
//       return;
//     }
//
//     try {
//       // Upload the image to Firebase Storage and get the URL
//       String imageUrl = await _databaseService.uploadImage(
//           widget.currentuser.Useremail, _vehicleImage!);
//
//       // Save the vehicle details in Firestore
//       await _databaseService.addVehicleDetails(
//           widget.currentuser.Useremail,
//           _registrationNumberController.text,
//           _brandController.text,
//           _typeController.text,
//           imageUrl);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Vehicle added successfully!")),
//       );
//
//       // Clear the fields
//       _registrationNumberController.clear();
//       _brandController.clear();
//       _typeController.clear();
//       setState(() {
//         _vehicleImage = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to add vehicle: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => HomePage())),
//           icon: Icon(LineAwesomeIcons.angle_left_solid),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Add a Vehicle',
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomePage())),
//                 child: Icon(Icons.home)),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Notifications())),
//                 child: Icon(Icons.notifications)),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: GestureDetector(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Profile(
//                               Current_User: this.widget.currentuser,
//                             ))),
//                 child: Icon(Icons.person)),
//             label: '',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   _vehicleImage != null
//                       ? CircleAvatar(
//                           radius: 64,
//                           backgroundImage: MemoryImage(_vehicleImage!),
//                         )
//                       : ClipRRect(
//                           child: Image.asset(
//                             'lib/images/car.jpg',
//                             width: 300,
//                             height: 300,
//                           ),
//                         ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: selectImage,
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.orange.withOpacity(0.9),
//                         ),
//                         child: Icon(
//                           LineAwesomeIcons.camera_solid,
//                           size: 30,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50),
//               TextFormField(
//                 controller: _registrationNumberController,
//                 decoration: InputDecoration(
//                     labelText: 'Registration Number',
//                     prefixIcon: Icon(LineAwesomeIcons.car_alt_solid),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10))),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _brandController,
//                 decoration: InputDecoration(
//                     labelText: 'Vehicle Brand',
//                     prefixIcon: Icon(LineAwesomeIcons.car_solid),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10))),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _typeController,
//                 decoration: InputDecoration(
//                     labelText: 'Vehicle Type',
//                     prefixIcon: Icon(LineAwesomeIcons.truck_solid),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10))),
//               ),
//               SizedBox(height: 50),
//               ElevatedButton(
//                 onPressed: saveVehicle,
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     side: BorderSide.none,
//                     shape: StadiumBorder()),
//                 child: Text(
//                   'Save Vehicle',
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plz/Pages/utils.dart';
//
// import '../components/user.dart';
//
// class AddVehicle extends StatefulWidget {
//   final MobileUser currentuser;
//
//   const AddVehicle({super.key, required this.currentuser});
//
//   @override
//   _AddVehicleState createState() => _AddVehicleState();
// }
//
// class _AddVehicleState extends State<AddVehicle> {
//   final _registrationNumberController = TextEditingController();
//   final _brandController = TextEditingController(); // Controller for brand
//   final _typeController = TextEditingController(); // Controller for type
//   Uint8List? _vehicleImage;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   void selectImage() async {
//     Uint8List? img = await pickImage(ImageSource.gallery);
//     setState(() {
//       _vehicleImage = img;
//     });
//   }
//
//   Future<void> saveVehicle() async {
//     try {
//       String imageUrl = '';
//
//       // Check if the image is selected
//       if (_vehicleImage != null) {
//         // If image is selected, upload it
//         String fileName =
//             'vehicles/${widget.currentuser.Useremail}/vehicle_${DateTime.now().millisecondsSinceEpoch}.jpg';
//         Reference storageRef = _storage.ref().child(fileName);
//
//         // Upload the image to Firebase Storage
//         UploadTask uploadTask = storageRef.putData(_vehicleImage!);
//         TaskSnapshot snapshot = await uploadTask;
//         imageUrl = await snapshot.ref.getDownloadURL();
//       }
//
//       // Save the vehicle details in Firestore
//       await _firestore
//           .collection('Users')
//           .doc(widget.currentuser.Useremail)
//           .collection('vehicles')
//           .add({
//         'number': _registrationNumberController.text,
//         'imageUrl': imageUrl, // Save the image URL, empty if no image
//         'brand': _brandController.text, // Save brand from input field
//         'type': _typeController.text, // Save type from input field
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Vehicle saved successfully!')),
//       );
//
//       // Navigate back or clear form
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to save vehicle: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Vehicle'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   _vehicleImage != null
//                       ? CircleAvatar(
//                           radius: 64,
//                           backgroundImage: MemoryImage(_vehicleImage!),
//                         )
//                       : SizedBox(
//                           width: 300,
//                           height: 300,
//                           child: ClipRRect(
//                             child: Image(
//                               image: AssetImage('lib/images/car.jpg'),
//                             ),
//                           ),
//                         ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: selectImage,
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.orange.withOpacity(0.9),
//                         ),
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 30,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50),
//               Form(
//                 child: Column(
//                   children: [
//                     // Registration Number Input
//                     TextFormField(
//                       controller: _registrationNumberController,
//                       decoration: InputDecoration(
//                         label: Text('Registration Number'),
//                         prefixIcon: Icon(Icons.directions_car),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Vehicle Brand Input
//                     TextFormField(
//                       controller: _brandController,
//                       decoration: InputDecoration(
//                         label: Text('Vehicle Brand'),
//                         prefixIcon: Icon(Icons.branding_watermark),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     // Vehicle Type Input
//                     TextFormField(
//                       controller: _typeController,
//                       decoration: InputDecoration(
//                         label: Text('Vehicle Type'),
//                         prefixIcon: Icon(Icons.category),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//
//                     SizedBox(
//                       width: 200,
//                       child: ElevatedButton(
//                         onPressed: saveVehicle,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           side: BorderSide.none,
//                           shape: StadiumBorder(),
//                         ),
//                         child: Text(
//                           'Save Vehicle',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plz/Pages/utils.dart';

import '../components/user.dart';

class AddVehicle extends StatefulWidget {
  final MobileUser currentuser;

  const AddVehicle({super.key, required this.currentuser});

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final _registrationNumberController = TextEditingController();
  final _brandController = TextEditingController(); // Controller for brand
  String _selectedVehicleType = 'Car'; // Initial selection for the vehicle type
  Uint8List? _vehicleImage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _vehicleImage = img;
    });
  }

  Future<void> saveVehicle() async {
    try {
      String imageUrl = '';

      // Check if the image is selected
      if (_vehicleImage != null) {
        // If image is selected, upload it
        String fileName =
            'vehicles/${widget.currentuser.Useremail}/vehicle_${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference storageRef = _storage.ref().child(fileName);

        // Upload the image to Firebase Storage
        UploadTask uploadTask = storageRef.putData(_vehicleImage!);
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      // Save the vehicle details in Firestore
      await _firestore
          .collection('Users')
          .doc(widget.currentuser.Useremail)
          .collection('vehicles')
          .add({
        'number': _registrationNumberController.text,
        'imageUrl': imageUrl, // Save the image URL, empty if no image
        'brand': _brandController.text, // Save brand from input field
        'type': _selectedVehicleType, // Save selected type from dropdown
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle saved successfully!')),
      );

      // Navigate back or clear form
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save vehicle: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _vehicleImage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_vehicleImage!),
                        )
                      : SizedBox(
                          width: 300,
                          height: 300,
                          child: ClipRRect(
                            child: Image(
                              image: AssetImage('lib/images/car.jpg'),
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.orange.withOpacity(0.9),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    // Registration Number Input
                    TextFormField(
                      controller: _registrationNumberController,
                      decoration: InputDecoration(
                        label: Text('Registration Number'),
                        prefixIcon: Icon(Icons.directions_car),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Vehicle Brand Input
                    TextFormField(
                      controller: _brandController,
                      decoration: InputDecoration(
                        label: Text('Vehicle Brand'),
                        prefixIcon: Icon(Icons.branding_watermark),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Vehicle Type Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedVehicleType,
                      decoration: InputDecoration(
                        labelText: 'Vehicle Type',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: ['Car', 'Van', 'Motorbike', 'Bus', 'Jeep']
                          .map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedVehicleType = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: saveVehicle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          side: BorderSide.none,
                          shape: StadiumBorder(),
                        ),
                        child: Text(
                          'Save Vehicle',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
