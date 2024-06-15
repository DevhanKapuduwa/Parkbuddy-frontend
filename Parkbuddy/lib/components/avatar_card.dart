import 'package:flutter/material.dart';
import 'contants_set.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // children: [
      //   Image.asset(
      //     "lib/images/profilepic.jpg",
      //     width: 80,
      //     height: 80,
      //   ),
        //const SizedBox(width: 10),
        //Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "lib/images/profilepic.jpg",
              width: 50,
              height: 50,
            ),

            const Text(
              "Michael John",
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
                color: kprimaryColor,
              ),
            ),
            Text(
              "Undergrad",
              style: TextStyle(
                fontSize: ksmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
        //   ],
        // ),
    ],
    );
    //);
  }
}
