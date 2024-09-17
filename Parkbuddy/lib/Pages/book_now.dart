import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:plz/Pages/park_details.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/shop.dart';
import 'package:plz/components/user.dart';
import 'package:provider/provider.dart';

import '../components/connect_firebase.dart';
import '../components/park_tile.dart';
import 'homepage.dart';
import 'notifications.dart';

class BookNowPage extends StatefulWidget {
  final MobileUser current_User;
  BookNowPage({super.key,required this.current_User});

  @override
  _BookNowPageState createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  bool firstSwitchValue = false;
  List<Park> displayedParks = [];
  TextEditingController _searchController = TextEditingController();
  List<Park> _searchResults = [];

  @override
  void initState() {
    super.initState();
    // Initialize the displayedParks list here
    // final shop = context.read<Shop>();
    // displayedParks = shop.bookNowParks;
    // print("Park list");
    // print(getparks());
    _initializeDisplayedParks();
  }

  Future<void> _searchParks(String searchQuery) async {
    List<Park> parks = await SearchPark(searchQuery);
    print("Searching..");
    setState(() {
      _searchResults = parks;
    });
  }

  Future<void> _initializeDisplayedParks() async {
    // Get the parks data from the database
    List<Park> parks = await getparks();
    // Update the state with the fetched parks
    setState(() {
      displayedParks = parks;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())),
          icon: Icon(LineAwesomeIcons.angle_left_solid),
        ),
        centerTitle: true,
        title: Text(
          'Book Now',
          style: TextStyle(
            fontSize: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.fontSize, // Use the same font size as headlineSmall
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Column(
                children: [
                  AnimatedToggleSwitch<bool>.size(
                    current: firstSwitchValue,
                    values: [false, true],
                    iconOpacity: 0.5,
                    indicatorSize: Size.fromWidth(100),
                    customIconBuilder: (context, local, global) => Text(
                      local.value ? 'Nearby' : 'Find Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.lerp(
                          Colors.black,
                          Colors.white,
                          local.animationValue,
                        ),
                      ),
                    ),
                    borderWidth: 3.0,
                    iconAnimationType: AnimationType.onHover,
                    style: ToggleStyle(
                      backgroundColor: Colors.grey.shade400,
                      indicatorColor: Colors.orange,
                      borderColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    selectedIconScale: 1.0,
                    onChanged: (value) =>
                        setState(() => firstSwitchValue = value),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (!firstSwitchValue) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _searchController,
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
                onChanged: (value)
                {
                  _searchParks(value);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
            child: _searchController.text.isNotEmpty
            ? _searchResults.isNotEmpty
            ?
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final park = _searchResults[index];
                return ParkTile(
                  park: park,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParkDetailsPage(
                          park: park,
                          current_User: widget.current_User,
                        ),
                      ),
                    );
                  },
                );
              },
            )
                :const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              ) :
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: displayedParks.length,
                itemBuilder: (context, index) {
                  final park = displayedParks[index];
                  return ParkTile(
                    park: park,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParkDetailsPage(park: park,current_User: widget.current_User),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
