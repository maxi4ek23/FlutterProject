import 'package:flutter/material.dart';

class MyCustomForm extends StatelessWidget {
  final bool isSecured;
  final Icon icon;
  final String hintText;

  const MyCustomForm({
    required this.isSecured,
    required this.icon,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      obscuringCharacter: '*',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
