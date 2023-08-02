import 'package:hive_flutter/hive_flutter.dart';

class loggedInHive {
  //initailizing hive and login box
  Future<void> initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox('isLoggedIn');
    await Hive.openBox('student_id');
  }

  //getting box
  static Box<dynamic> get box1 => Hive.box('isLoggedIn');
  static Box<dynamic> get box2 => Hive.box('student_id');
  //setting logged in state
  void setLoggedIn(String isLoggedIn) {
    box1.put('isLoggedIn', isLoggedIn);
  }

  void setStudentId(String student_id) {
    box2.put('student_id', student_id);
  }

  //getting logged in state
  String getLoggedIn() {
    return box1.get('isLoggedIn').toString();
  }

  String getStudentId() {
    return box2.get('student_id').toString();
  }

  void removeStudentId() {
    box2.delete('student_id');
  }
}
