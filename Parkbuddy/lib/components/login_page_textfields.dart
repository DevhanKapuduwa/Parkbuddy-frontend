import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController thiscontroller;
  final String hinttext;
  final bool obscuretext;

  const LoginTextField(
      {super.key,
      required this.thiscontroller,
      required this.hinttext,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscuretext,
        controller: thiscontroller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          fillColor: Colors.white70,
          filled: true,
          hintText: hinttext,
        ),
      ),
    );
  }
}
