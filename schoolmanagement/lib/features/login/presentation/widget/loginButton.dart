import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';

class LoginButton extends StatelessWidget {
  final String text;

  final dynamic onPressed;

  const LoginButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: primaryColor,
      child: InkWell(
          canRequestFocus: true,
          focusColor: const Color.fromARGB(52, 255, 255, 255),
          splashColor: const Color.fromARGB(52, 255, 255, 255),
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )),
    );
  }
}
