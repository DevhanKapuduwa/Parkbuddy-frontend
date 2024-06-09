import 'package:flutter/material.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      margin: const EdgeInsets.symmetric(horizontal: 60),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey.shade400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/images/google.png',
            height: 40,
          ),
          const Text(
            "Sign-in with Google",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
          ),
        ],
      ),
    );
  }
}
