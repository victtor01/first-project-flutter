import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool pass;

  const CustomTextInput({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.pass = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: pass,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        hintStyle: TextStyle(
          color: Colors.black.withAlpha(
            (255 * 0.2).toInt(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black.withAlpha((255 * 0.2).toInt()),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
