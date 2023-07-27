import 'package:flutter/material.dart';

Widget primaryButton(function, text) {
  return ElevatedButton(
    onPressed: function,
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
