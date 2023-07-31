import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:http/http.dart' as http;

class assignmentApi {
  //funtion to get all assignments
  Future<List<assignment>> getAllAssignment() async {
    try {
      // Get all assignments from the server
      final response = await http
          .get(Uri.parse('http://localhost:3000/students/12/assignments'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body.toString());
        // If response is ok, then return a list of assignments
        return (jsonData as List)
            .map((json) => assignment.fromJson(json))
            .toList();
      } else {
        // If response is not ok, throw an exception
        throw Exception('Failed to load students');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching students: $e');
      throw Exception('Failed to fetch students $e');
    }
  }

  //funtion to post student
  Future<List<assignment>> postAssignment(assignment assignment) async {
    try {
      final response = await http.post(Uri.parse(appUrl.assignmentPost),
          body: jsonEncode(assignment.toJson()));
      // If response is ok, then return a list of assignment
      if (response.statusCode == 200) {
        print('successfully posted');
        return getAllAssignment(); //return all students
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