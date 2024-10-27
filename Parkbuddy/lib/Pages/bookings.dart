import 'package:flutter/material.dart';
import 'package:plz/components/List_tiles/Bookings_tile.dart';
import 'package:plz/components/user.dart';

class BookingsPage extends StatelessWidget {
  final List<Booking>Booking_list;
  const BookingsPage({super.key,required this.Booking_list});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookings",style: TextStyle(fontWeight: FontWeight.bold),),



      ),
      body: Booking_list.isEmpty?Center(
        child: Text(
          "No Currently bookings..",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
      ) :ListView.builder(
          itemCount: Booking_list.length,
            itemBuilder: (context,index)
            {
              return BookingsTile(currentBooking: this.Booking_list[index]);


            }
        ),

    );
  }
}
