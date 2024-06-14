import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plz/Pages/cart_page.dart';
import 'package:plz/Pages/park_details.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/shop.dart';
import 'package:plz/Pages/side_menu.dart';
import 'package:plz/Pages/signin.dart';
import 'package:plz/components/park_tile.dart';
import 'package:plz/components/park_type.dart';
import 'package:provider/provider.dart';

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
    ['Book now', true],
    ['Booked', false],
  ];

  // List of parks for "Booked" (currently empty)
  final List<Park> bookedParks = [];

  // Currently displayed parks
  List<Park> displayedParks = [];

  @override
  void initState() {
    super.initState();
    // Initialize the displayedParks list here
    displayedParks = [];
  }

  // User tap on park types
  void parkTypeSelected(int index) {
    final shop = context.read<Shop>();
    final bookNowParks = shop.bookNowParks;

    setState(() {
      // Makes every selection false by keeping true only desired
      for (int i = 0; i < parkType.length; i++) {
        parkType[i][1] = false;
      }
      parkType[index][1] = true;

      // Update the displayed parks based on the selected type
      if (index == 0) {
        displayedParks = bookNowParks;
      } else if (index == 1) {
        displayedParks = bookedParks;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final bookNowParks = shop.bookNowParks;

    // Initialize displayedParks in build method as well
    if (displayedParks.isEmpty) {
      displayedParks = bookNowParks;
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 15),
          child: IconButton(
            icon: Icon(Icons.menu, size: 35, color: Colors.white),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SideMenu())),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage())),
            icon: const Icon(
              Icons.shopping_cart,
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayedParks.length,
              itemBuilder: (context, index) {
                final park = displayedParks[index];
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
              },
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
  final String rating;
  final String description;

  Park({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.rating,
    required this.description,
  });
}
