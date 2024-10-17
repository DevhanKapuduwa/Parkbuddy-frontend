import 'package:flutter/material.dart';

import '../Pages/shop.dart';

class ParkTile extends StatelessWidget {
  final Park park;
  final VoidCallback onTap;

  ParkTile({
    required this.park,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 30.0,right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(3),
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.black,
          ),
          child: Column(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(park.imagePath),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      park.name,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
              // Price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(children: [Text("View"),Icon(Icons.add)],),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
