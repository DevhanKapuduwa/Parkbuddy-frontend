import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/sidebar_menu.dart';
import 'package:plz/Pages/signin.dart';
import 'package:rive/rive.dart';

import '../components/info_card.dart';
import 'homepage.dart';
import 'notifications.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Colors.white,

        child: SideMenuTile(),


      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [



        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Divider(
            color: Colors.black,
            height: 1,
          ),
        ),

        InfoCard(
          name: "Devhan",profession: "Undergrad",
        ),


        Padding(
          padding: const EdgeInsets.only(left: 24.0,top: 32,bottom: 16),
          child: Text(
            "Browse".toUpperCase(),
            style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.black),


          ),
        ),


        SidebarMenuWidget(
          title: "Profile",icon: LineAwesomeIcons.person_booth_solid,onPress: (){},
          //isActive: false,
        ),


        SidebarMenuWidget(
          title: "Settings",icon: LineAwesomeIcons.cog_solid,onPress: (){},
         // isActive: true,
        ),

        SidebarMenuWidget(
          title: "Add Vehicle",icon: LineAwesomeIcons.car_solid,onPress: (){},
          isActive: false,
        ),

        SidebarMenuWidget(
          title: "Book a Car park",icon: LineAwesomeIcons.parking_solid,onPress: (){},
         // isActive: true,
        ),


      ],
    );
  }
}



