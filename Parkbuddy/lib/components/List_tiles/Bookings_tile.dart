import 'package:flutter/material.dart';
import 'package:plz/components/user.dart';
import 'package:intl/intl.dart'; // For date formatting

class BookingsTile extends StatelessWidget {
  final Booking currentBooking;
  const BookingsTile({super.key, required this.currentBooking});

  // Function to calculate the remaining time and return the appropriate border color
  Color getBorderColor() {
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime.parse(currentBooking.startTime.toString());
    final Duration difference = startTime.difference(now);

    if (difference.isNegative) {
      return Colors.red; // Already started
    } else if (difference.inDays >= 1) {
      return Colors.green; // More than 1 day remaining
    } else {
      return Colors.orange; // Less than 1 day remaining
    }
  }

  String getRemainingTime() {
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime.parse(currentBooking.startTime.toString());
    final Duration difference = startTime.difference(now);

    if (difference.isNegative) {
      return 'Started';
    } else {
      final int hours = difference.inHours;
      final int minutes = difference.inMinutes.remainder(60);
      if (difference.inDays >= 1) {
        return '${difference.inDays} days remaining';
      } else {
        return '${hours}h ${minutes}m remaining';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: getBorderColor(), // Dynamic border color
            width: 4.0, // Adjust the width as needed
          ),
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car Park: ${currentBooking.parkLotId}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Vehicle: ${currentBooking.vehicleId}'),
                const SizedBox(height: 8),
                Text('Start: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(currentBooking.startTime.toString()))}'),
                const SizedBox(height: 8),
                Text('End: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(currentBooking.endTime.toString()))}'),
                const SizedBox(height: 8),
                Text('Total Amount: Rs.${currentBooking.totalAmount}'),
                const SizedBox(height: 8),
                Text('Time Until Start: ${getRemainingTime()}'), // Display remaining time
              ],
            ),
          ),
        ),
      ),
    );
  }
}
