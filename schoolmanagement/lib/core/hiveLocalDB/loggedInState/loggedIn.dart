import 'package:hive_flutter/hive_flutter.dart';

class loggedInHive {
  //initailizing hive and login box
  Future<void> initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox('isLoggedIn');
  }

  //getting box
  static Box<dynamic> get box => Hive.box('isLoggedIn');
  //setting logged in state
  void setLoggedIn(String isLoggedIn) {
    box.put('isLoggedIn', isLoggedIn);
  }

  //getting logged in state
  String getLoggedIn() {
    return box.get('isLoggedIn').toString();
  }
}
