import 'package:flutter/material.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentWidgets.dart';

class LoginTextField extends StatelessWidget {
  final String text;
  final bool isPassword;
  final TextEditingController controller;
  final IconData? suffixIconData;
  final Function? onSuffixIconTap;
  const LoginTextField({
    super.key,
    required this.text,
    this.isPassword = false,
    required this.controller,
    this.suffixIconData,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFFE9D7FB),
        child: TextFormField(
          style: const TextStyle(
              color: Color(0xFF200123), fontWeight: FontWeight.bold),
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            suffixIcon:
                SuffixIconButton(icon: suffixIconData, onTap: onSuffixIconTap),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: text,
            hintStyle: const TextStyle(
              color: Color(0xFF966AC0),
            ),
          ),
        ),
      ),
    );
  }
}
