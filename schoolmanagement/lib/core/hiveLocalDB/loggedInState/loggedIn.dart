import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class loggedInHive {
  //initailizing hive and login box
  Future<void> initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox('isLoggedIn');
    await Hive.openBox('loginInfo');
  }

  //getting box
  static Box<dynamic> get box1 => Hive.box('isLoggedIn');
  static Box<dynamic> get box2 => Hive.box('loginInfo');
  //setting logged in state
  void setLoggedIn(String isLoggedIn) {
    box1.put('isLoggedIn', isLoggedIn);
  }

  void setLoginInfo(dynamic loginInfo) {
    box2.put('loginInfo', loginInfo);
  }

  //getting logged in state
  String getLoggedIn() {
    return box1.get('isLoggedIn').toString();
  }

  String getLoginInfo() {
    return box2.get('loginInfo').toString();
  }

  void removeLoginInfo() {
    box2.delete('loginInfo');
  }
}
