import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentWidgets.dart';
import '../../bloc/assignment_bloc.dart';

class addAssignment extends StatefulWidget {
  const addAssignment({super.key});

  @override
  State<addAssignment> createState() => _addAssignmentState();
}

class _addAssignmentState extends State<addAssignment> {
  //function to show the date/time picker and at the same time
  //it updates the due date in text field using the dueDateAddedEvent
  dateTime() async {
    dueDate = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );
    context.read<AssignmentBloc>().add(dueDateAddedEvent(dueDate: dueDate));
  }

  //create text field controllers to add assignment
  TextEditingController descriptionController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController assignmentIdController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController assignmentTitleController = TextEditingController();
  TextEditingController driveLinkController = TextEditingController();
  DateTime? dueDate;
  List<String> filePaths = [];
  List<String> classRoomID = ['C002', '2', '3', '4', '5'];
  List<String> subject = ["EEEG101", 'math', 'science'];
  // List<File> selectedFiles = [];
  // List<String> selectedFilesPaths = [];
  // List<int> fileSizes = [];
  String? selectedClassRoomID;
  String? selectedSubject;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignmentBloc, AssignmentState>(
        listener: (context, state) {
      //for loading screen
      if (state.isLoading) {
        LoadingScreen().show(
            context: context, text: state.message ?? "Please wait a moment");
      } else {
        LoadingScreen().hide();
      }
      //To update of choosen classroom in the dropdown field
      //Also TO change the options of subject according to the class room selected
      if (state is selectClassroomState) {
        selectedClassRoomID = state.classroom_id.toString();
        print(selectedClassRoomID);
      }
      //to show snackbar when assignment is added
      if (state is assignmentAddState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Assignments submitted successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
      //to update the due date in its text field
      if (state is dueDateAddedState) {
        dueDateController.text = state.dueDate.toString();
      }
      //to update the selected files in the listview
      // if (state is selectFilesState) {
      //   selectedFiles = state.files;
      //   selectedFilesPaths = selectedFiles.map((e) => e.path).toList();
      //   fileSizes = selectedFiles.map((file) => file.lengthSync()).toList();
      // }
      //to show snackbar when error occurs
      if (state is assignmentErrorState) {
        print(state.message);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${state.message}"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                Row(
                  children: [
                    DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      hint: Text(" Select Class Room ID"),
                      value: selectedClassRoomID,
                      items: classRoomID.map((option) {
                        return DropdownMenuItem(
                          child: Text(option),
                          value: option,
                        );
                      }).toList(),
                      onChanged: (value) {
                        context
                            .read<AssignmentBloc>()
                            .add(selectClassroomEvent(classroom_id: value!));
                      },
                    ),
                    DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      hint: Text(" Select the Subject"),
                      value: selectedSubject,
                      items: subject.map((option) {
                        return DropdownMenuItem(
                          child: Text(option),
                          value: option,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubject = value!;
                        });
                      },
                    ),
                  ],
                ),

                //add text fields to add assignment

                TextField(
                  controller: teacherIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter teacher',
                  ),
                ),

                TextField(
                  controller: assignmentIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter assignment id',
                  ),
                ),
                TextField(
                  controller: assignmentTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter title',
                  ),
                ),

                TextField(
                  controller: dueDateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Due date',
                      suffixIcon: SuffixIconButton1(
                          icon: Icon(Icons.edit_calendar_outlined),
                          onTap: () async {
                            await dateTime();
                          })),
                  readOnly: true,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                TextField(
                  controller: driveLinkController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Drive Link',
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () async {
                //       context.read<AssignmentBloc>().add(selectFilesEvent());
                //     },
                //     child: Text("Add file")),
                //List view to show files if files are selected
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: selectedFiles.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(selectedFilesPaths[index].split('/').last),
                //       subtitle: Text(
                //           "${(fileSizes[index] / 1024).toStringAsFixed(2)} KB"),
                //     );
                //   },
                // ),

                ElevatedButton(
                    onPressed: () {
                      if (dueDate != null &&
                          selectedClassRoomID != null &&
                          selectedSubject != null &&
                          assignmentIdController.text.trim() != '' &&
                          assignmentTitleController.text.trim() != '') {
                        context
                            .read<AssignmentBloc>()
                            .add(createAssignmentEvent(
                              newAssignment: assignment(
                                classroom_id: selectedClassRoomID.toString(),
                                teacher_id: teacherIdController.text.trim(),
                                subject_id: selectedSubject.toString(),
                                assignment_id:
                                    assignmentIdController.text.trim(),
                                assignment_name:
                                    assignmentTitleController.text.trim(),
                                assignment_description:
                                    descriptionController.text.trim(),
                                assignment_file:
                                    driveLinkController.text.trim(),
                                assignment_deadline: dueDate!,
                                created_date: DateTime.now(),
                              ),
                              classroom_id: selectedClassRoomID.toString(),
                              teacher_id: teacherIdController.text.trim(),
                            ));
                      } else {
                        // Handle the case when the assigned date is not selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill the required fields"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit")),
              ],
            )),
          ),
        ),
      );
    });
  }
}
