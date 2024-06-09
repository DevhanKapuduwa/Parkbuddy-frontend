import 'package:flutter/material.dart';

class ParkTile extends StatelessWidget {
  final String parkImagePath;
  final String parkName;
  final String parkPrice;

  ParkTile({
   required this.parkImagePath,
    required this.parkName,
    required this.parkPrice,
});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0,bottom: 70.0),
      child: Container(
          padding: EdgeInsets.all(12),
          width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Column(
          children: [
            //image
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
                child: Image.asset(parkImagePath),
            ),

            SizedBox(height: 20,),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
              child: Column(
                children: [
                  Text(
                    parkName,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                  ),
                  Text(
                    'With indoor parking',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            //price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs. ' + parkPrice + ' / hr',
                  style: TextStyle(fontSize: 18),),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
