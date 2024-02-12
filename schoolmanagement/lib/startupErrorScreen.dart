import 'package:flutter/material.dart';
import 'package:schoolmanagement/initial_setup.dart';

class StartUpErrorPage extends StatelessWidget {
  final String errorMessage;
  const StartUpErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(children: [
          Text('Error: $errorMessage occured while initializing the app'),
          ElevatedButton(onPressed: () => appStartUp(), child: Text('Refresh'))
        ]),
      )),
    );
  }
}
