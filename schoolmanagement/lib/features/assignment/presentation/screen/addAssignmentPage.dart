import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentWidgets.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';
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
    // ignore: use_build_context_synchronously
    context.read<AssignmentBloc>().add(dueDateAddedEvent(dueDate: dueDate));
  }

  //create text field controllers to add assignment
  TextEditingController descriptionController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController assignmentTitleController = TextEditingController();
  TextEditingController driveLinkController = TextEditingController();
  DateTime? dueDate;
  List<String> filePaths = [];
  List<String> classRoomID = ['C002', '2', '3', '4', '5'];
  List<String> subject = ["EEEG101", 'math', 'science'];
  File? selectedFile;
  String? selectedFilePath;
  int? fileSize;
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
      //To update of chosen classroom in the dropdown field
      //Also TO change the options of subject according to the class room selected
      if (state is selectClassroomState) {
        selectedClassRoomID = state.classroom_id.toString();
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
      // to update the selected files in the listView
      if (state is selectFilesState) {
        selectedFile = state.file;
        selectedFilePath = state.file.path;
        fileSize = state.file.lengthSync();
      }
      //to show snackbar when error occurs
      if (state is assignmentErrorState) {
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
                      hint: const Text(" Select Class Room ID"),
                      value: selectedClassRoomID,
                      items: classRoomID.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
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
                      hint: const Text(" Select the Subject"),
                      value: selectedSubject,
                      items: subject.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
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
                  controller: assignmentTitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter title',
                  ),
                ),

                TextField(
                  controller: dueDateController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Due date',
                      suffixIcon: SuffixIconButton1(
                          icon: const Icon(Icons.edit_calendar_outlined),
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
                ElevatedButton(
                  onPressed: () async {
                    context.read<AssignmentBloc>().add(selectFilesEvent());
                  },
                  child: const Text("Add file"),
                ),
                Column(
                  children: [
                    Text(selectedFilePath == null
                        ? ''
                        : selectedFilePath!.split('/').last),
                    Text(fileSize == null
                        ? ''
                        : '${(fileSize! / 1024).toStringAsFixed(2)} KB')
                  ],
                ),

                ElevatedButton(
                    onPressed: () {
                      if (dueDate != null &&
                          selectedClassRoomID != null &&
                          selectedSubject != null &&
                          assignmentTitleController.text.trim() != '') {
                        if (state is FileSelectedState) {
                          //TODO : Checks the file contains pdf or not
                          if (state.file.path.contains('.pdf')) {
                            addAssignmentWithFile(context, state);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Only pdf files allowed"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 300,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      const Text(
                                          "You have not selected a file to upload\nDo you want to continue?"),
                                      ElevatedButton(
                                          onPressed: () {
                                            addAssignment(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Ok"))
                                    ],
                                  ),
                                );
                              });
                        }
                      } else {
                        // Handle the case when the assigned date is not selected
                        const CustomSnackBar(
                            message: '"Please fill the required fields"',
                            timeInSeconds: 2);
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

  void addAssignmentWithFile(
      BuildContext context, FileSelectedState state) async {
    context.read<AssignmentBloc>().add(
          createAssignmentEvent(
            newAssignment: assignment(
              classroom_id: selectedClassRoomID.toString(),
              teacher_id: teacherIdController.text.trim(),
              subject_id: selectedSubject.toString(),
              assignment_name: assignmentTitleController.text.trim(),
              assignment_description: descriptionController.text.trim(),
              assignment_file: state.file.uri.pathSegments.last,
              assignment_deadline: dueDate!,
              created_date: DateTime.now(),
            ),
            toUploadFile: state.file,
            classroom_id: selectedClassRoomID.toString(),
            teacher_id: teacherIdController.text.trim(),
          ),
        );
  }

  void addAssignment(BuildContext context) {
    context.read<AssignmentBloc>().add(
          createAssignmentEvent(
            newAssignment: assignment(
              classroom_id: selectedClassRoomID.toString(),
              teacher_id: teacherIdController.text.trim(),
              subject_id: selectedSubject.toString(),
              assignment_name: assignmentTitleController.text.trim(),
              assignment_description: descriptionController.text.trim(),
              assignment_file: driveLinkController.text.trim(),
              assignment_deadline: dueDate!,
              created_date: DateTime.now(),
            ),
            toUploadFile: null,
            classroom_id: selectedClassRoomID.toString(),
            teacher_id: teacherIdController.text.trim(),
          ),
        );
  }
}
