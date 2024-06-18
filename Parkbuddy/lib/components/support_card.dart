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
        color: Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            Icons.support_agent,
            size: 50,
            color: Colors.orange,
          ),
          SizedBox(width: 10),
          Text(
            "Feel Free to Ask, We Are Ready to Help",
            style: TextStyle(
              fontSize: ksmallFontSize,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
