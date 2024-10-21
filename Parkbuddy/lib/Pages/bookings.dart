import 'package:flutter/material.dart';
import 'package:plz/components/List_tiles/Bookings_tile.dart';
import 'package:plz/components/user.dart';

class BookingsPage extends StatelessWidget {
  final List<Booking>Booking_list;
  const BookingsPage({super.key,required this.Booking_list});

  @override
  Widget build(BuildContext context) {
    print("&**&*");
    print(Booking_list[0].vehicleId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings",style: TextStyle(fontWeight: FontWeight.bold),),



      ),
      body: ListView.builder(
          itemCount: Booking_list.length,
            itemBuilder: (context,index)
            {
              return BookingsTile(currentBooking: this.Booking_list[index]);


            }
        ),

    );
  }
}
