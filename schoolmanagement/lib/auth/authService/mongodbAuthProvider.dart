import 'package:schoolmanagement/auth/authService/authProvider.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/core/allUser/student/studentModal.dart';

import 'authException.dart';

class mongoDBAuth implements authProvider {
  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Future<void> forgotPassword({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> login({required String id, required String password}) async {
    try {
      // await Future.delayed(Duration(seconds: 5));
      http.Response response =
          await http.post(Uri.parse(appUrl.loginUrl), body: {
        'email': id,
        'password': password,
      });
      if (response.statusCode == 200) {
        //TO:DO
        //logic to save login state
        //make isLogin boolean true and save it (locally)
        print('successfull');
      } else if (response.statusCode == 404) {
        throw userNotFoundAuthException();
      } else if (response.statusCode == 401) {
        throw wrongPasswordAuthExceptions();
      } else {
        throw genericAuthException();
      }
    } catch (e) {
      throw genericAuthException();
    }
  }

  @override
  Future<void> logout() {
    //TO:DO
    //logic for logout state
    //make isLogin boolean false and save it (locally)
    return Future.value();
  }

  @override
  bool? isLoggedIn = null;
}
