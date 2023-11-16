import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  print("Handling a background message: ${message.messageId}");
  //save it to the local_storage
  //as it runs in a separate instance from the app it cannot
  //update the state of the app or any UI elements
  //but it can run IO like local_storage,database etc,

  //Not checked for fetch request
}
