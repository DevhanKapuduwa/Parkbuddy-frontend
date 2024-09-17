

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plz/Pages/authrization.dart';
import 'package:plz/Pages/bookings.dart';
import 'package:plz/Pages/cart_page.dart';
import 'package:plz/Pages/chat_page.dart';
import 'package:plz/Pages/map_page.dart';
import 'package:plz/Pages/ordinalbot.dart';
import 'package:plz/Pages/park_details.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/shop.dart';
import 'package:plz/Pages/signin.dart';
import 'package:plz/Pages/update_profile.dart';
import 'package:plz/components/avatar_card.dart';
import 'package:plz/components/connect_firebase.dart';
import 'package:plz/components/park_tile.dart';
import 'package:plz/components/user.dart';
import 'package:provider/provider.dart';

import 'book_now.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var current_User;

  void userlogout() {
    FirebaseAuth.instance.signOut();
  }

  getcuruser() async {
    var cur_user=await getUser(widget.user?.email??"");

    current_User=cur_user;
    print("Current user:${cur_user.Useremail}");



  }

  // Currently displayed parks
  List<Park> displayedParks = [];

  @override
  void initState() {
    super.initState();
    // Initialize the displayedParks list here
    final shop = context.read<Shop>();
    displayedParks = shop.bookNowParks;
    getcuruser();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.user==null){
      userlogout();
    }
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, size: 35, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: AvatarCard(),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile())),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.edit_document),
              title: Text('Edit profile'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateProfile())),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text('Add a Vehicle'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushNamed('/page2');
              },
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.home_work),
              title: Text('Book a Car Park'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushNamed('/page2');
              },
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('My Bookings'),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushNamed('/page2');
              },
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Ordinalbot())),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatPage())),
            ),
            Divider(
              height: 3,
              color: Colors.grey.shade800,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sign Out'),
                onTap: ()=>{
                userlogout(),
                Navigator.push(context, MaterialPageRoute(builder: (context) => Pagedecider()))
                }
            ),
          ],
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
                    MaterialPageRoute(builder: (context) => MapPage())),
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
              onChanged: (e) => getcuruser(),//change this later
            ),
          ),
          SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookNowPage(current_User: current_User)),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Center(
                            child: Text(
                              'Book Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Spacer(),

              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingsPage()),
                    );
                  },
                  child: Container(
                    width: 154,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Center(
                            child: Text(
                              'Bookings',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          // Popular car parks title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular car parks",
                style: GoogleFonts.bebasNeue(fontSize: 30),
              ),
            ),
          ),
          SizedBox(height: 15),
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
                        builder: (context) => ParkDetailsPage(park: park,current_User: current_User,),
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

// class Park {
//   final String imagePath;
//   final String name;
//   final String price;
//   final String rating;
//   final String description;
//   final String extension;
//   int quantity;
//
//   Park({
//     required this.imagePath,
//     required this.name,
//     required this.price,
//     required this.rating,
//     required this.description,
//     required this.extension,
//     this.quantity = 1,
//   });
// }
