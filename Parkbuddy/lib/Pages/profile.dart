import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/profile_menu.dart';
import 'package:plz/Pages/update_profile.dart';

import 'homepage.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage())),icon: Icon(LineAwesomeIcons.angle_left_solid),),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(LineAwesomeIcons.home_solid))
        ],
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
                      child: Icon(LineAwesomeIcons.pencil_alt_solid, size: 18,color: Colors.black),
                    ),
                  )

                ],
              ),
              SizedBox(height: 10),

              Text('ssasdasd',
              style: Theme.of(context).textTheme.headlineMedium),
              Text('ssasdfdfsd',
                  style: Theme.of(context).textTheme.headlineSmall),

              SizedBox(height: 20),

              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UpdateProfile())),
                    style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,side: BorderSide.none,shape: StadiumBorder()
                    ) ,child: Text('trtrtrt',style: TextStyle(color: Colors.black),)
                ),
              ),

              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10),


              ProfileMenuWidget(
                title: "Settings",icon: LineAwesomeIcons.cog_solid,onPress: (){},
              ),
              ProfileMenuWidget(
                title: "Billing Details",icon: LineAwesomeIcons.wallet_solid,onPress: (){},
              ),
              ProfileMenuWidget(
                title: "Information",icon: LineAwesomeIcons.user_check_solid,onPress: (){},
              ),
              Divider(color: Colors.grey,),
              SizedBox(height: 10,),
              ProfileMenuWidget(
                title: "Vehicle data",icon: LineAwesomeIcons.info_solid,onPress: (){},
              ),
              ProfileMenuWidget(
                title: "Logout",icon: LineAwesomeIcons.sign_out_alt_solid,
                textColor:Colors.red,endIcon:false,onPress: (){},
              ),

            ],
          ),

        ),
      ),
    );
  }
}


