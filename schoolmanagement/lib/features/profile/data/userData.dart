import 'dart:convert';

import '../../../../core/hiveLocalDB/loggedInState/loggedIn.dart';

class UserProfile {
  Future<Map<String, dynamic>> getUserProfile() async {

    final jsonData = await json.decode(loggedInHive().getLoginInfo());
    print(jsonData);
    return jsonData;
  }
}
