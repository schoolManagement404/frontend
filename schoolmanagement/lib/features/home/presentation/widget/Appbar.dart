import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.centerTitle,
    required this.parentContext,
  }) : super(key: key);

  final bool? centerTitle;
  final parentContext;
  @override
  Widget build(BuildContext context) {
    const numberOfNotifications = "2";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 0,
        leading: Image.network(
          "https://activelearninglab.ku.edu.np/assets/img/KU%20logo.png",
          height: 35,
          width: 35,
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              "Student Name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(parentContext, '/messages');
                },
                icon: const Icon(Icons.notifications_none_rounded,
                    color: primaryColor, size: 30),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        numberOfNotifications,
                        style: TextStyle(
                          color: backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
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
            icon: const Icon(Icons.arrow_back_ios)),
        Text(
          headerText,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
