// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404 Page Not Found',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 30,
              ),
            ),
            const Text('Please check your route'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            )
          ],
        ),
      ),
    );
  }
}
