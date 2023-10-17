import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/core/allUser/student/studentModal.dart';
import 'package:http/http.dart' as http;

class studentApi {
  //funtion to get all students
  Future<List<student>> getAllStudents() async {
    try {
      // Get all students from the server
      final response = await http.get(Uri.parse(appUrl.allStudentUrl));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body.toString());
        // If response is ok, then return a list of students
        return (jsonData as List)
            .map((json) => student.fromJson(json))
            .toList();
      } else {
        // If response is not ok, throw an exception
        throw Exception('Failed to load students');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching students: $e');
      throw Exception('Failed to fetch students');
    }
  }

  //funtion to post student
  Future<List<student>> postStudent(student student) async {
    try {
      final response = await http.post(Uri.parse(appUrl.allStudentUrl),
          body: jsonEncode(student.toJson()));
      // If response is ok, then return a list of students
      if (response.statusCode == 201) {
        print('successfully posted');
        return getAllStudents(); //return all students
      } else {
        throw Exception('Failed to post student');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while posting student: $e');
      throw Exception('Failed to post student');
    }
  }
}
