import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.centerTitle,
    this.location,
    required this.parentContext,
  }) : super(key: key);
  final String? location;
  final bool? centerTitle;
  final BuildContext parentContext;
  @override
  Widget build(BuildContext context) {
    String hiveLoginInfo = loggedInHive().getLoginInfo();
    //convert this string to JSON
    Map<String, dynamic> jsonLoginInfo = jsonDecode(hiveLoginInfo);
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Welcome,",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              jsonLoginInfo['data']['student']['name'],
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
                  if (location == "noticedetails") {
                    print("You are already in NoticeDetails page");
                  }
                  if (location == "Notice") {
                    print("You are already in Notice page");
                  } else {
                    Navigator.pushNamed(context, "/notices");
                  }
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
  final BuildContext parentContext;
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
