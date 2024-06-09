import 'package:flutter/material.dart';

class ParkType extends StatelessWidget {
  final String parkType;
  final bool isSelected;
  final VoidCallback onTap;

  ParkType({
    required this.parkType,
    required this.isSelected,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left:25.0),
        child: Text(
            parkType,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.orange : Colors.white,
          ),
        ),
      ),
    );
  }
}
