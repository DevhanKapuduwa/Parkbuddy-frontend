import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void userlogout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        actions: [
          IconButton(
            onPressed: userlogout,
            icon: const Icon(
              Icons.logout_rounded,
              size: 35,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
          )
        ],
      ),
    );
  }
}
