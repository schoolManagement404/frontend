import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/core/notifications/firebase_api.dart';
import 'package:schoolmanagement/core/notifications/notification.dart';
import 'package:schoolmanagement/firebase_options.dart';
import 'package:schoolmanagement/injector.dart';

Future<void> init() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await loggedInHive().initializeHive();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseApi.initNotificationFirebase();
}
