import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.color,
    required this.colorIcon,
    required this.icon,
    required this.onPressed,
  });

  final Color color;
  final Color colorIcon;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 45,
        height: 45,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            icon,
            color: colorIcon,
            size: 28,
          ),
        ),
      ),
    );
  }
}
