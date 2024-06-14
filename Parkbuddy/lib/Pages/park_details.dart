import 'package:flutter/material.dart';
import 'package:plz/Pages/profile.dart';
import 'package:plz/Pages/shop.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'notifications.dart';

class ParkDetailsPage extends StatefulWidget {
  final Park park;

  const ParkDetailsPage({super.key, required this.park});

  @override
  State<ParkDetailsPage> createState() => _ParkDetailsPageState();
}

class _ParkDetailsPageState extends State<ParkDetailsPage> {
  int quantityCount = 0;

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void addToCart() {
    if (quantityCount > 0) {
      final shop = context.read<Shop>();
      shop.addToCart(widget.park, quantityCount);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: Color.fromARGB(255, 138, 60, 55),
            content: Text("Successfully added to cart",
            style: TextStyle(
              color: Colors.white,
            ),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(onPressed: () {
                Navigator.pop(context);

                Navigator.pop(context);
              },
                icon: Icon(Icons.done,color: Colors.white,),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.park.name),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  Image.asset(widget.park.imagePath),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 5, height: 5),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade800,
                      ),
                      SizedBox(width: 5, height: 5),
                      Text(
                        widget.park.rating,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.park.name,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rs. ' + widget.park.price + ' / hr',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.park.description,
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 138, 60, 55),
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$" + widget.park.price,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            onPressed: decrementQuantity,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: incrementQuantity,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.2) // Text color
                  ),
                  onPressed: addToCart,
                  child: Row(
                    children: [
                      Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

