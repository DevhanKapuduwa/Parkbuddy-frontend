import 'package:flutter/material.dart';

import '../../Pages/shop.dart';

class ParkTile_map extends StatelessWidget {
  final Park park;
  final VoidCallback onTap;

  ParkTile_map({
    required this.park,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 5.0,right: 5,top: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(3),
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.black,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  park.imagePath,
                ),
              ),
              // The widget you want to overlay on top of the image
              Positioned(
                bottom: 0, // You can adjust this to control the position

                // You can adjust this to control the position
                child: (Container(
                  width: 283,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.symmetric(horizontal: BorderSide(width: 3,color: Colors.orange),vertical: BorderSide(width: 2,color: Colors.orange)),

                    color: Colors.black.withOpacity(0.9), // Add some transparency
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Text(
                        park.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color for contrast
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(Icons.navigate_next,color: Colors.white,),
                      )
                    ],
                  ),
                )),
              ),
            ],
          )
        ),
      ),
    );
  }
}
