import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';

import 'package:http/http.dart' as http;

import '../model/feeModel.dart';

class StudentFeeApi {
  //funtion to get all StudentFees
  Future<List<StudentFee>> getStudentFees(String studentID) async {
    try {
      // Get all StudentFees from the server
      final response = await http
          .get(Uri.parse('http://localhost:3000/students/12/assignments'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body.toString());
        // If response is ok, then return a list of StudentFees
        return (jsonData as List)
            .map((json) => StudentFee.fromJson(json))
            .toList();
      } else {
        // If response is not ok, throw an exception
        throw Exception('Failed to load StudentFees');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching StudentFees: $e');
      throw Exception('Failed to fetch StudentFees');
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
