import 'package:flutter/material.dart';
import 'package:plz/Pages/onboarding.dart';
import 'authrization.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap:() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => Onboarding())),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/welcome.jpg'),
              fit: BoxFit.cover,
            )
          )
        ),
      ),
    );
  }
}
