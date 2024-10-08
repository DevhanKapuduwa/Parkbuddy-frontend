import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/car_image_provider.dart';
import 'package:plz/Pages/utils.dart';
import 'package:plz/components/user.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'notifications.dart';
import 'profile.dart';

class AddVehicle extends StatefulWidget {
  final MobileUser currentuser;
  const AddVehicle({super.key, required this.currentuser});

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      context.read<CarImageProvider>().updateCarImage(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    final carImageProvider = context.watch<CarImageProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())),
          icon: Icon(LineAwesomeIcons.angle_left_solid),
        ),
        centerTitle: true,
        title: Text(
          'Add a Vehicle',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
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
                              Current_User: this.widget.currentuser,
                            ))),
                child: Icon(Icons.person)),
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Stack(
                  children: [
                    carImageProvider.carImage != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                MemoryImage(carImageProvider.carImage!),
                          )
                        : SizedBox(
                            width: 300,
                            height: 300,
                            child: ClipRRect(
                              //  borderRadius: BorderRadius.circular(100),
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
                            LineAwesomeIcons.camera_solid,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(
                            'Registration Number',
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.car_alt_solid),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddVehicle(
                                      currentuser: this.widget.currentuser))),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              side: BorderSide.none,
                              shape: StadiumBorder()),
                          child: Text(
                            'Save Vehicle',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
