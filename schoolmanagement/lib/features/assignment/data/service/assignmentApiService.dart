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

        final assignments = jsonData.map((json) {
          return assignment(
              // Map other assignment attributes here
              classroom_id: json['classroom_id'],
              teacher_id: json['teacher_id'],
              subject_id: json['subject_id'],
              assignment_id: json['assignment_id'],
              assignment_name: json['assignment_name'],
              assignment_description: json['assignment_description'],
              assignment_deadline: DateTime.parse(json['assignment_deadline']),
              created_date: DateTime.parse(json['created_date']),
              assignment_file: json['assignment_file']);
        }).toList();

        return assignments;
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