import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'signin.dart';

class Pagedecider extends StatefulWidget {
  Pagedecider({super.key});

  @override
  State<Pagedecider> createState() => _PagedeciderState();
}

class _PagedeciderState extends State<Pagedecider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            //return Signin(); should be used later
            return Signin();
          }
        },
      ),
    );
  }
}
