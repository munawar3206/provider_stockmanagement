
import 'package:flutter/material.dart';

class text2 extends StatelessWidget {
  const text2({
    super.key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
  });

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
