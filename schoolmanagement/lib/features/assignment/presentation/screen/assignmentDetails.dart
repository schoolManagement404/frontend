import 'package:flutter/material.dart';

import '../../data/model/assignment.dart';

class AssignmentDetailPage extends StatelessWidget {
  final assignment currentAssignment;

  AssignmentDetailPage({required this.currentAssignment});

  @override
  Widget build(BuildContext context) {
    TextEditingController driveLinkController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Detail'),
      ),
      body: Column(
        children: <Widget>[
          Text('Assignment: ${currentAssignment.assignment_name}'),
          Text('Subject: ${currentAssignment.subject_id}'),
          Text('Teacher: ${currentAssignment.teacher_id}'),
          Text('Description: ${currentAssignment.assignment_description}'),
          Text('File: ${currentAssignment.assignment_file}'),
          Text(
              'Deadline: ${currentAssignment.assignment_deadline.toIso8601String().split("T")[0].toString()}'),
          Text(
              'Assigned Date: ${currentAssignment.created_date.toIso8601String().split("T")[0].toString()}'),

          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Add Drive Link"),
                        content: TextField(
                          controller: driveLinkController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Drive Link',
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                // bloc for student posting assignment
                                Navigator.pop(context);
                              },
                              child: Text("Add")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.add)),

          // Display other assignment details
        ],
      ),
    );
  }
}
