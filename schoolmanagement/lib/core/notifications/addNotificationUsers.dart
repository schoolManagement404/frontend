import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolmanagement/core/notifications/notification_user_model.dart';

class AddNotifier {
  static void addNotificationUsersToDatabase(
      NotificationUser notificationUserModel) {
    FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

    final NotificationUser notificationUser = NotificationUser(
      userId: notificationUserModel.userId,
      name: notificationUserModel.name,
      fcmToken: notificationUserModel.fcmToken,
    );

    firebaseInstance
        .collection('notificationUsers')
        .doc(notificationUserModel.userId)
        .set(notificationUser.toJson())
        .then((value) => print("Notification User Added"))
        .catchError(
            (error) => print("Failed to add notification user: $error"));
  }
}
