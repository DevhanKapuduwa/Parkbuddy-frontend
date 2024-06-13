import 'package:flutter/material.dart';
import 'contants_set.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.yellow.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.support_agent,
            size: 50,
            color: Colors.yellow,
          ),
          SizedBox(width: 10),
          Text(
            "Feel Free to Ask, We Are Ready to Help",
            style: TextStyle(
              fontSize: ksmallFontSize,
              color: ksecondryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
