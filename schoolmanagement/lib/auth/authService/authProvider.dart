import 'package:schoolmanagement/core/allUser/student/studentModal.dart';

abstract class authProvider {
  //initialize
  Future<void> initialize();
  //login
  Future<void> login({
    required String id,
    required String password,
  });
  //logout
  Future<void> logout();
  //forgot password
  Future<void> forgotPassword({
    required String id,
  });
}
