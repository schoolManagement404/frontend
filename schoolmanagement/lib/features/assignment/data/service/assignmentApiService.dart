import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:http/http.dart' as http;

class AssignmentApi {
  //funtion to get all assignments
  Future<List<assignment>> getAllAssignment({required String userId}) async {
    try {
      // Get all assignments from the server
      final response = await http.get(Uri.parse(appUrl.assigmentUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;

        return (jsonData).map((json) => assignment.fromJson(json)).toList();
      } else {
        // If response is not ok, throw an exception
        throw Exception('Error Status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching assignment: $e');
      throw Exception('Failed to fetch assignments: $e');
    }
  }

  //funtion to post student
  Future<assignment> postAssignment(assignment assignment) async {
    try {
      final response = await http.post(
        Uri.parse(appUrl.assignmentPost),
        body: jsonEncode(assignment.toJson()),
        //add header
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print("Assignment posted successfully");
        return assignment;
      } else {
        print("Assignment not posted, Status code: ${response.statusCode}");
        throw Exception(
            'Assignment not posted, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while posting assignment: $e');
      throw Exception('Failed to post assignment: $e');
    }
  }
}
