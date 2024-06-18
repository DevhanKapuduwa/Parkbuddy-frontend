import 'package:flutter/material.dart';
import 'package:plz/Pages/onboarding.dart';
import 'authrization.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    // Navigate to the Onboarding screen after 3 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(), // Spacer to push the loader to the bottom
            CircularProgressIndicator(), // Circular progress indicator
          ],
        ),
      ),
    );
  }
}
