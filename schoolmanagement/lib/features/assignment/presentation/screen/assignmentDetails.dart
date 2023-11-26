import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoolmanagement/features/assignment/data/service/add_assignment_file_firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/model/assignment.dart';
import 'package:http/http.dart' as http;

class AssignmentDetailPage extends StatelessWidget {
  final assignment currentAssignment;

  const AssignmentDetailPage({super.key, required this.currentAssignment});

  Future<String> getAssignmentUrl() async {
    String url =
        await downloadURLExample(fileName: currentAssignment.assignment_file);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController driveLinkController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Detail'),
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
          FutureBuilder(
              future: getAssignmentUrl(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(children: [
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: PDFView(
                        filePath: snapshot.data.toString(),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PDFView(
                                      filePath: snapshot.data.toString(),
                                    )));
                      },
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ]);
                } else {
                  return const CircularProgressIndicator();
                }
              }),

          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Add Drive Link"),
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
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                // bloc for student posting assignment
                                Navigator.pop(context);
                              },
                              child: const Text("Add")),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.add)),

          // Display other assignment details
        ],
      ),
    );
  }
}
