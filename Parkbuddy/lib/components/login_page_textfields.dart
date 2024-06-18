import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController thiscontroller;
  final String hinttext;
  final bool obscuretext;

  const LoginTextField({
    super.key,
    required this.thiscontroller,
    required this.hinttext,
    required this.obscuretext,
  });

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      // This will trigger a rebuild to apply the fillColor change
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.obscuretext,
        controller: widget.thiscontroller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2.5)),
          fillColor:
              _focusNode.hasFocus ? Colors.grey.shade900 : Colors.grey.shade600,
          filled: true,
          hintText: widget.hinttext,
        ),
      ),
    );
  }
}
