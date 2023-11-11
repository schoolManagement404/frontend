import 'dart:convert';
import 'dart:io';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:http/http.dart' as http;

class assignmentApi {
  //funtion to get all assignments
  Future<List<assignment>> getAllAssignment({required String userId}) async {
    try {
      // Get all assignments from the server
      final response = await http
          .get(Uri.parse('http://10.0.2.2:3000/students/$userId/assignments'));
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
        Uri.parse("http://10.0.2.2:3000/teachers/12/assignments"),
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

  //  ***EXAMPLE assignment to be fetched***
  // try {
  //   List<Assignment> assignments = await assignmentApi.getAssignments();
  //   assignments.forEach((assignment) {
  //     print('Assignment Title: ${assignment.assignmentTitle}');
  //     print('Description: ${assignment.description}');
  //     print('Due Date: ${assignment.dueDate}');
  //     print('Assigned Date: ${assignment.assignedDate}');
  //     print('File URL: ${assignment.fileUrl}');
  //     print('-----------------------');
  //   });
  // } catch (e) {
  //   print('Error: $e');
  // }


// ***EXAMPLE assignment to be posted***
//   Assignment newAssignment = Assignment(
//     assignmentTitle: 'New Assignment',
//     description: 'Complete the new task',
//     dueDate: DateTime(2023, 8, 15),
//     assignedDate: DateTime.now(),
//     fileUrl: 'https://example.com/new_assignment',
//   );

//   try {
//     await assignmentApi.postAssignment(newAssignment);
//   } catch (e) {
//     print('Error: $e');
//   }
// }