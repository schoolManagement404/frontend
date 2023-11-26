import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoolmanagement/features/assignment/data/service/add_assignment_file_firebase_api.dart';
import 'package:path_provider/path_provider.dart';
import '../../../home/presentation/widget/Appbar.dart';
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
    final assignedDate = DateTime.parse("${currentAssignment.created_date}");
    final deadlineDate =
        DateTime.parse("${currentAssignment.assignment_deadline}");
    return Scaffold(
      appBar: CustomAppBar(parentContext: context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
                headerText: "${currentAssignment.subject_id}",
                parentContext: context),
            SizedBox(
              height: 8,
            ),
            Text(
              '${currentAssignment.assignment_name}',
              style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 17)),
            ),
            Text(
              '${currentAssignment.teacher_id}',
              style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 17)),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 30,
              width: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: Colors.red),
              child: Center(
                child: Text(
                  "Due",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${deadlineDate.year}-${deadlineDate.month}-${deadlineDate.day}",
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 30,
            ),
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
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: driveLinkController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                labelText: 'Enter the drive Link',
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Submit Assignmnet",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      // body: Column(
      //   children: <Widget>[
      //     Text('Assignment: ${currentAssignment.assignment_name}'),
      //     Text('Subject: ${currentAssignment.subject_id}'),
      //     Text('Teacher: ${currentAssignment.teacher_id}'),
      //     Text('Description: ${currentAssignment.assignment_description}'),
      //     Text('File: ${currentAssignment.assignment_file}'),
      //     Text(
      //         'Deadline: ${currentAssignment.assignment_deadline.toIso8601String().split("T")[0].toString()}'),
      //     Text(
      //         'Assigned Date: ${currentAssignment.created_date.toIso8601String().split("T")[0].toString()}'),

      //     IconButton(
      //         onPressed: () {
      //           showDialog(
      //               context: context,
      //               builder: (BuildContext context) {
      //                 return AlertDialog(
      //                   title: const Text("Add Drive Link"),
      //                   content: TextField(
      //                     controller: driveLinkController,
      //                     decoration: const InputDecoration(
      //                       border: OutlineInputBorder(),
      //                       labelText: 'Drive Link',
      //                     ),
      //                   ),
      //                   actions: [
      //                     TextButton(
      //                         onPressed: () {
      //                           Navigator.pop(context);
      //                         },
      //                         child: const Text("Cancel")),
      //                     TextButton(
      //                         onPressed: () {
      //                           // bloc for student posting assignment
      //                           Navigator.pop(context);
      //                         },
      //                         child: const Text("Add")),
      //                   ],
      //                 );
      //               });
      //         },
      //         icon: const Icon(Icons.add)),

      //     // Display other assignment details
      //   ],
      // ),
    );
  }
}
