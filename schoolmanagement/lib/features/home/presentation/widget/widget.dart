import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.centerTitle,
    required this.parentContext,
    this.isnotice,
  }) : super(key: key);

  final bool? centerTitle;
  final parentContext;
  final bool? isnotice;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Image.network(
          "https://activelearninglab.ku.edu.np/assets/img/KU%20logo.png",
        ),
        title: Column(
          children: [
            Text(
              "Welcome,",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "Student Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        actions: [
          Visibility(
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(parentContext, '/notices');
                },
                icon: Icon(Icons.notifications)),
            visible: isnotice ?? true,
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 56.0);
}

class CustomSnackBar {
  final String message;
  final int timeInSeconds;
  const CustomSnackBar({required this.message, required this.timeInSeconds});

  static show({
    required BuildContext context,
    required message,
    required timeInSeconds,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      elevation: 0.0,
      duration: Duration(seconds: timeInSeconds),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      )),
    ));
  }
}

class CustomHeader extends StatelessWidget {
  final String headerText;
  final parentContext;
  const CustomHeader(
      {super.key, required this.headerText, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(parentContext);
            },
            icon: Icon(Icons.arrow_back_ios)),
        Text(
          headerText,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
