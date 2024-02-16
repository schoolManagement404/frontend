import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:schoolmanagement/app.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/core/notifications/addNotificationUsers.dart';
import 'package:schoolmanagement/core/notifications/localNotification/fcmLocalNotification.dart';
import 'package:schoolmanagement/core/notifications/notification.dart';
import 'package:schoolmanagement/core/notifications/notification_user_model.dart';

const androidChannel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  description: 'Channel for important notification',
  importance: Importance.max,
);
final localNotification = FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

class FirebaseMessagingApi {
// android channel for local notification
//local notification required because fcm doesn't
//proovide notification when app is in foreground

  static void _handleNotificationClick(RemoteMessage message) {
    final notificationData = message.data;
    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      navigatorKey.currentState?.pushNamed(screen);
    }
  }

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
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        provisional: true,
      );
      //getting the fcmToken
      if (kDebugMode) {
        print("Notification Settings: $notificationSettings");
      }

      final fcmToken = await FirebaseMessaging.instance.getToken();

      print("FCM Token: $fcmToken");

      //Convert it ot NotificationUserClass
      NotificationUser notificationUser = NotificationUser(
        userId: studentId,
        name: studentName,
        fcmToken: fcmToken!,
      );

      // while app is in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        if (kDebugMode) {
          print('Got a message whilst in the foreground!');
        }

        if (message.notification!.title != null &&
            message.notification!.body != null) {
          final notificationData = message.data;
          final screen = notificationData['screen'];
          final notification = message.notification;
          if (notification == null) return;
          await localNotification.initialize(
            InitializationSettings(android: initializationSettingsAndroid),
            onDidReceiveNotificationResponse: (details) {
              Map<String, dynamic> payloadMap = jsonDecode(details.payload!);
              String? screen = payloadMap['data']['screen'];
              if (screen != null) {
                _handleNotificationClick(message);
              }
            },
          );
          await localNotification
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.createNotificationChannel(androidChannel);
          if (Platform.isAndroid) {
            localNotification.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                    android: AndroidNotificationDetails(
                  androidChannel.id,
                  androidChannel.name,
                  channelDescription: androidChannel.description,
                  icon: '@drawable/ic_launcher',
                  importance: androidChannel.importance,
                  priority: Priority.high,
                  ticker: 'ticker',
                )),
                payload: jsonEncode(message.toMap()));
          }
        }
        if (kDebugMode) {
          print(
              'Message also contained a notification: ${message.notification!.title}');
        }
        //Update the listeners in the app and update the notification list UI
      });
      //  while app is in background
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Handling the initial message received when the app is launched from dead (killed state)
      // When the app is killed and a new notification arrives when user clicks on it
      // It gets the data to which screen to open
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          _handleNotificationClick(message);
        }
      });

// Handling a notification click event when the app is in the background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint(
            'onMessageOpenedApp: ${message.notification!.title.toString()}');

        _handleNotificationClick(message);
      });
      // Handling a notification click event by navigating to the specified screen

      //Add it to the database
      AddNotifier.addNotificationUsersToDatabase(notificationUser);
    } else {
      //do nothing
    }
  }
}
