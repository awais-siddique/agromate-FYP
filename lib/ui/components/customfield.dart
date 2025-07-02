import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.green)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.green),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}
