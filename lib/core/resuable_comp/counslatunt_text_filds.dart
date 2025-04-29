import 'package:flutter/material.dart';

class CustomTextField  extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const CustomTextField ({required this.label, required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          // Less rounded for rectangle look
          borderSide: const BorderSide(
            color: Colors.black87,
            width: 1, // Thicker border
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.black87, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.0, // Even thicker when focused
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
      ),
      style: const TextStyle(color: Colors.black87), // Text color
    );
  }
}
