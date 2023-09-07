import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class text extends StatelessWidget {
  const text({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Valid Values';
        }

        return null;
      },
    );
  }
}
