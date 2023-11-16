import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/core/notifications/addNotificationUsers.dart';
import 'package:schoolmanagement/core/notifications/notification_user_model.dart';

class FirebaseApi {
  static Future<void> initNotificationFirebase() async {
    //check if the user is already logged in
    //if logged in, then get the fcm token and add it to the database
    //if not logged in, then do nothing
    // ignore: no_leading_underscores_for_local_identifiers

    String hiveState = loggedInHive().getLoggedIn();
    if (hiveState == "true") {
      //get the fcm token and add it to the database
      String hiveLoginInfo = loggedInHive().getLoginInfo();
      //convert this string to JSON
      Map<String, dynamic> jsonLoginInfo = jsonDecode(hiveLoginInfo);
      String studentId = jsonLoginInfo['data']['student']['student_id'];
      String studentName = jsonLoginInfo['data']['student']['name'];

      // request notification permission
      final notificationSettings =
          await FirebaseMessaging.instance.requestPermission(provisional: true);
      //getting the fcmToken
      if (kDebugMode) {
        print("Notification Settings: $notificationSettings");
      }

      final fcmToken = await FirebaseMessaging.instance.getToken();

      //Convert it ot NotificationUserClass
      NotificationUser notificationUser = NotificationUser(
        userId: studentId,
        name: studentName,
        fcmToken: fcmToken!,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print('Got a message whilst in the foreground!');
        }

        if (message.notification != null) {
          if (kDebugMode) {
            print(
                'Message also contained a notification: ${message.notification!.title}');
          }
          //Update the listeners in the app and update the notification list UI
        }
      });

      //Add it to the database
      AddNotifier.addNotificationUsersToDatabase(notificationUser);
    } else {
      //do nothing
    }
  }
}
