import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/utils.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'notifications.dart';
import 'profile.dart';
import 'profile_image_provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      context.read<ProfileImageProvider>().updateProfileImage(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = context.watch<ProfileImageProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile())),
          icon: Icon(LineAwesomeIcons.angle_left_solid),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
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
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile())),
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
                    profileImageProvider.profileImage != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                MemoryImage(profileImageProvider.profileImage!),
                          )
                        : SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: AssetImage('lib/images/profilepic.jpg'),
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.orange.withOpacity(0.9),
                          ),
                          child: Icon(
                            LineAwesomeIcons.camera_solid,
                            size: 18,
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
                            'Full Name',
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.user),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(
                            'Email',
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.envelope_open),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(
                            'Phone No',
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.phone_solid),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(
                            'New password',
                          ),
                          prefixIcon: Icon(LineAwesomeIcons.fingerprint_solid),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile())),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              side: BorderSide.none,
                              shape: StadiumBorder()),
                          child: Text(
                            'Save Profile',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Joined on ',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                text: '7 June 2024',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.withOpacity(0.3),
                              elevation: 0,
                              foregroundColor: Colors.orange,
                              shape: StadiumBorder(),
                              side: BorderSide.none),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
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
