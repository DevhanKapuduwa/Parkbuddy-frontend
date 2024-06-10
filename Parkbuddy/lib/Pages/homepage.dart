// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plz/Pages/profile.dart';
// import 'package:plz/components/park_tile.dart';
// import 'package:plz/components/park_type.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({super.key});
//   final user = FirebaseAuth.instance.currentUser;
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   void userlogout() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   //list pof park types
//   final List parkType =[
//     //[parkType,isSelected]
//     ['Free',true],
//     ['Paid',false],
//     ['Outdoor',false],
//     ['Indoor',false],
//   ];
//
//   //user tap on park types
//   void parkTypeSelected(int index) {
//       setState(() {
//         //makes every selection false by keeping true only desired
//         for(int i=0;i<parkType.length;i++)
//           {
//             parkType[i][1] = false;
//           }
//         parkType[index][1] = true;
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 15.0,top: 15),
//           child: Icon(Icons.menu, size: 35,color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             onPressed: userlogout,
//             icon: const Icon(
//               Icons.logout_rounded,
//               size: 35,
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.only(right: 15,top: 15),
//           )
//         ],
//       ),
//
//       bottomNavigationBar: BottomNavigationBar(
//
//         items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home),
//         label: '',),
//         BottomNavigationBarItem(icon: Icon(Icons.notifications),
//           label: '',),
//         BottomNavigationBarItem(icon: GestureDetector(
//             onTap: () => Navigator.push(context,
//             MaterialPageRoute(builder: (context) => Profile())),
//             child: Icon(Icons.person)
//         ),
//           label: '',),
//       ],
//       ),
//       body: Column(children: [
//
//         SizedBox(height: 20),
//         //finding the best park for you
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 35.0),
//           child: Text(
//             "Find the best parking spot for you",
//             style: GoogleFonts.bebasNeue(
//               fontSize: 45
//             ),
//           ),
//         ),
//
//         SizedBox(height: 15),
//
//         //search bar
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25.0),
//           child: TextField(
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search),
//               hintText: 'Search your desired car park....',
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade600),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey.shade600)
//               ),
//             ),
//           ),
//         ),
//
//         SizedBox(height: 25),
//
//         //horizontal listview of park types
//         Container(
//           height: 50,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: parkType.length,
//               itemBuilder: (context,index){
//             return ParkType(
//                 parkType: parkType[index][0],
//                 isSelected: parkType[index][1],
//                 onTap: () {
//                   parkTypeSelected(
//                           index
//                   );
//                 },
//             );
//
//         })
//         ),
//
//         //horizontal listview of park tiles
//         Expanded(
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 ParkTile(
//                   parkImagePath: 'lib/images/ogf.jpg',
//                   parkName: 'OGF',
//                   parkPrice: '100',
//                 ),
//                 ParkTile(
//                   parkImagePath: 'lib/images/kcc.jpg',
//                   parkName: 'KCC',
//                   parkPrice: '200',
//                 ),
//                 ParkTile(
//                   parkImagePath: 'lib/images/ccc.jpg',
//                   parkName: 'CCC',
//                   parkPrice: '100',
//                 ),
//               ],
//             ),
//         ),
//       ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plz/Pages/park_details.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/side_menu.dart';
import 'package:plz/Pages/signin.dart';
import 'package:plz/components/park_tile.dart';
import 'package:plz/components/park_type.dart';

import 'notifications.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void userlogout() {
    FirebaseAuth.instance.signOut();
  }

  // List of park types
  final List parkType = [
    ['Free', true],
    ['Paid', false],
    ['Outdoor', false],
    ['Indoor', false],
  ];

  // User tap on park types
  void parkTypeSelected(int index) {
    setState(() {
      // Makes every selection false by keeping true only desired
      for (int i = 0; i < parkType.length; i++) {
        parkType[i][1] = false;
      }
      parkType[index][1] = true;
    });
  }

  final List<Park> parks = [
    Park(
      imagePath: 'lib/images/ogf.jpg',
      name: 'OGF',
      price: '100',
    ),
    Park(
      imagePath: 'lib/images/kcc.jpg',
      name: 'KCC',
      price: '200',
    ),
    Park(
      imagePath: 'lib/images/ccc.jpg',
      name: 'CCC',
      price: '100',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 15.0, top: 15),


        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, size: 35, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),

          // child: Icon(
          //     Icons.menu, size: 35, color: Colors.white),
          // child: IconButton(
          //   icon: Icon(Icons.menu, size: 35, color: Colors.white),
          //   onPressed: () => Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SideMenu())),
          // ),
          // child: Icon(
          //     Icons.menu, size: 35, color: Colors.white),
        ),
        actions: [
          IconButton(
             onPressed: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Signin())),
            icon: const Icon(
              Icons.logout_rounded,
              size: 35,
              color: Colors.white,
            ),
            padding: EdgeInsets.only(right: 15, top: 15),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage())),
                child: Icon(Icons.home)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Notifications())),
                child: Icon(Icons.notifications)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profile())),
                child: Icon(Icons.person)),
            label: '',
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Finding the best park for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              "Find the best parking spot for you",
              style: GoogleFonts.bebasNeue(fontSize: 45),
            ),
          ),
          SizedBox(height: 15),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search your desired car park....',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          // Horizontal ListView of park types
          Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: parkType.length,
                itemBuilder: (context, index) {
                  return ParkType(
                    parkType: parkType[index][0],
                    isSelected: parkType[index][1],
                    onTap: () {
                      parkTypeSelected(index);
                    },
                  );
                }),
          ),
          // Horizontal ListView of park tiles
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: parks.map((park) {
                return ParkTile(
                  park: park,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParkDetailsPage(park: park),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Park {
  final String imagePath;
  final String name;
  final String price;

  Park({
    required this.imagePath,
    required this.name,
    required this.price,
  });
}
