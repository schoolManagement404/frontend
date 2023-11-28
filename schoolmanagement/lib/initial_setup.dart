import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:schoolmanagement/core/constants/constant.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/core/home_widget/update_widget.dart';
import 'package:schoolmanagement/core/notifications/firebase_api.dart';
import 'package:schoolmanagement/core/notifications/notification.dart';
import 'package:schoolmanagement/features/assignment/data/model/dummy_assignmnet.dart';
import 'package:schoolmanagement/firebase_options.dart';
import 'package:schoolmanagement/injector.dart';

Future<void> init() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await loggedInHive().initializeHive();
  await FirebaseApi.initNotificationFirebase();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  HomeWidget.setAppGroupId(appGroupId);
  updateAssignment(dummyAssignment);
}
