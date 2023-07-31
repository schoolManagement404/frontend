import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoolmanagement/auth/authService/authProvider.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/core/allUser/student/studentModal.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';

import 'authException.dart';

class mongoDBAuth implements authProvider {
  @override
  Future<void> initialize() async {
    //not initilizing mongodb beacuse user can open app without internet
    //instead initializing hive for local storage
    await loggedInHive().initializeHive();
  }

  @override
  Future<void> forgotPassword({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> login({required String id, required String password}) async {
    try {
      http.Response response =
          await http.post(Uri.parse(appUrl.loginUrl), body: {
        'email': id,
        'password': password,
      });
      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        loggedInHive().setLoggedIn('true');
        print('successfully logged in');
      } else if (response.statusCode == 404) {
        print(response.statusCode.toString());
        throw userNotFoundAuthException();
      } else if (response.statusCode == 400) {
        print(response.statusCode.toString());
        throw wrongPasswordAuthExceptions();
      } else {
        print(response.statusCode.toString());
        throw genericAuthException();
      }
    } catch (e) {
      throw genericAuthException();
    }
  }

  @override
  Future<void> logout() {
    loggedInHive().setLoggedIn('false');
    return Future.value();
  }
}
