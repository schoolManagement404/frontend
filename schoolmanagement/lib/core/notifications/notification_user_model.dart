class NotificationUser {
  final String userId;
  final String name;
  final String fcmToken;

  const NotificationUser(
      {required this.userId, required this.name, required this.fcmToken});

  factory NotificationUser.fromJson(Map<String, dynamic> json) {
    return NotificationUser(
      userId: json['userId'],
      name: json['name'],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'fcmToken': fcmToken,
      };

  @override
  String toString() {
    return 'NotificationUser(userId: $userId, name: $name, fcmToken: $fcmToken)';
  }
}
