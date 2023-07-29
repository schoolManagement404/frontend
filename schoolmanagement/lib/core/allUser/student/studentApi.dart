import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/core/allUser/student/studentModal.dart';
import 'package:http/http.dart' as http;

class studentApi {
  Future<List<student>> getAllStudents() async {
    try {
      // Get all students from the server
      final response = await http.get(Uri.parse(appUrl.allStudentUrl));
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        // If response is ok, then return a list of students
        List<student> students = [];
        for (var u in data) {
          student studentData = student.fromJson(u);
          students.add(studentData);
        }
        return students;
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
}
