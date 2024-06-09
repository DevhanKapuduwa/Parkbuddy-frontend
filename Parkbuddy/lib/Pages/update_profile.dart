import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/profile.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => Profile())),
          icon: Icon(LineAwesomeIcons.angle_left_solid),),
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
          Stack(
          children: [
          SizedBox(
          width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(image: AssetImage('lib/images/ogf.jpg'),),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.yellow.withOpacity(0.7),
              ),
              child: Icon(LineAwesomeIcons.camera_solid, size: 18,color: Colors.black),
            ),
          ),

          ],
        ),
              SizedBox(height: 50,),
              Form(child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Full Name',),
                      prefixIcon: Icon(LineAwesomeIcons.user),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Email',),
                      prefixIcon: Icon(LineAwesomeIcons.envelope_open),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Phone No',),
                      prefixIcon: Icon(LineAwesomeIcons.phone_solid),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),

                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('New password',),
                      prefixIcon: Icon(LineAwesomeIcons.fingerprint_solid),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UpdateProfile())),
                        style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,side: BorderSide.none,shape: StadiumBorder()
                        ) ,child: Text('trtrtrt',style: TextStyle(color: Colors.black),)
                    ),
                  ),

                  SizedBox(height: 20,),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Joined on ',
                          style: TextStyle(
                            fontSize: 12
                          ),
                          children: [
                            TextSpan(text: '7 June 2024',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, 
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: StadiumBorder(),
                            side: BorderSide.none
                          ),
                        child: Text('Delete'),
                      ),
                    ],
                  )

                ],
              ))
        ],
        ),
      ),
    ),
    );
  }
}
