// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:schoolmanagement/auth/authService/authProvider.dart';
import 'package:http/http.dart' as http;
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';

import 'authException.dart';

// ignore: camel_case_types
class mongoDBAuth implements authProvider {
  @override
  Future<void> initialize() async {
    //not initializing mongodb because user can open app without internet
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
      const emulatorUrl = 'http://10.0.2.2:3000/auth/login';
      //check current running platform
      //if platform is android then use emulator url
      //else use web url

      final response = await http.post(
        Uri.parse(emulatorUrl),
        body: jsonEncode({
          'id': id,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        loggedInHive().setLoggedIn('true');
        print("response: ${response.body.toString()}");
        loggedInHive().setLoginInfo(response.body);
        print('successfully logged in');
      } else if (response.statusCode == 404) {
        throw userNotFoundAuthException();
      } else if (response.statusCode == 401) {
        throw wrongPasswordAuthException();
      } else {
        print("GA1");
        throw genericAuthException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    loggedInHive().setLoggedIn('false');
    loggedInHive().removeLoginInfo();
    return Future.value();
  }
}
