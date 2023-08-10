import 'dart:convert';

import 'package:schoolmanagement/config/appUrl/appUrl.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:http/http.dart' as http;

class assignmentApi {
  //funtion to get all assignments
  Future<List<assignment>> getAllAssignment(
      {required String student_id}) async {
    try {
      // Get all assignments from the server
      final response = await http
          .get(Uri.parse('http://localhost:3000/students/12/assignments'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;

        final assignments = jsonData.map((json) {
          final List<String> fileUrls =
              (json['assignment_file'] as List<dynamic>)
                  .map((dynamic url) => url.toString())
                  .toList();

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
            assignment_file: fileUrls, // Assign file URLs to assignment_file
          );
        }).toList();

        return assignments;
      } else {
        // If response is not ok, throw an exception
        throw Exception('Failed to load assignments');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching assignment: $e');
      throw Exception('Failed to fetch assignment $e');
    }
  }

  //funtion to post student
  Future<List<assignment>> postAssignment(assignment assignment) async {
    try {
      //multipart request for posting assignment files
      final request = http.MultipartRequest(
          'POST', Uri.parse('http://10.0.2.2:3000/teachers/12/assignments'));
      final assignmentData = assignment.toJson();
      assignmentData.forEach((key, value) {
        request.fields[key] = value.toString();
      });
      for (String filePath in assignment.assignment_file) {
        request.files.add(await http.MultipartFile.fromPath(
          'assignment_file',
          filePath,
        ));
      }
      final response = await request.send();
      // If response is ok, then return a list of assignment
      if (response.statusCode == 200) {
        print('successfully posted');
        return getAllAssignment(student_id: '12'); //return all assignments
      } else {
        throw Exception('Failed to post assignment');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
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