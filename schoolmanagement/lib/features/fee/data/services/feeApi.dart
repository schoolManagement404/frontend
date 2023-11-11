import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';

import 'package:http/http.dart' as http;

import '../model/feeModel.dart';

class StudentFeeApi {
  //funtion to get all StudentFees
  Future<List<StudentFee>> getStudentFees(String studentID) async {
    print(studentID);
    try {
      // Get all StudentFees from the server
      final response = await http.get(
          Uri.parse('http://10.0.2.2:3000/students/${studentID}/fee_status'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;
        // If response is ok, then return a list of StudentFees
        return (jsonData).map((json) => StudentFee.fromJson(json)).toList();
      } else {
        print(response.statusCode);
        // If response is not ok, throw an exception
        throw Exception('Error status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching StudentFees: $e');
      throw Exception('Failed to fetch StudentFees: $e');
    }
  }

  //funtion to post StudentFee
  Future<List<StudentFee>> postStudentFee(StudentFee StudentFee) async {
    try {
      final response = await http.post(Uri.parse('url'),
          body: jsonEncode(StudentFee.toJson()));
      // If response is ok, then return a list of StudentFees
      if (response.statusCode == 201) {
        print('successfully posted');
        return getStudentFees(''); //return all StudentFees
      } else {
        throw Exception('Failed to post StudentFee');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while posting StudentFee: $e');
      throw Exception('Failed to post StudentFee');
    }
  }
}
