import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../../bloc/assignment_bloc.dart';

class addAssignment extends StatefulWidget {
  const addAssignment({super.key});

  @override
  State<addAssignment> createState() => _addAssignmentState();
}

class _addAssignmentState extends State<addAssignment> {
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
  }

  assignmentApi addAssignment = assignmentApi();
  //create text field controllers to add assignment
  TextEditingController classRoomIdController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  TextEditingController assignmentIdController = TextEditingController();
  TextEditingController subjectIdController = TextEditingController();

  DateTime? dueDate;
  TextEditingController fileUrlController = TextEditingController();
  TextEditingController assignmentTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignmentBloc>(
        create: (context) => AssignmentBloc(),
        child: BlocConsumer<AssignmentBloc, AssignmentState>(
            listener: (context, state) {
          if (state.isLoading) {
            LoadingScreen().show(
                context: context,
                text: state.message ?? "Please wait a moment");
          } else {
            LoadingScreen().hide();
          }
        }, builder: (context, state) {
          if (state is assignmentAddState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Assignments loaded successfully!"),
                duration: Duration(seconds: 2),
              ),
            );
          }

          if (state is assignmentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.message}"),
                duration: const Duration(seconds: 2),
              ),
            );
          }
          return Scaffold(
            body: Center(
                child: Column(
              children: [
                //add text fields to add assignment
                TextField(
                  controller: classRoomIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter class room id',
                  ),
                ),
                TextField(
                  controller: teacherIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter teacher',
                  ),
                ),
                TextField(
                  controller: subjectIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter class subject',
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
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                TextField(
                  controller: fileUrlController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'file url TODO: add file upload',
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await dateTime();
                    },
                    icon: const Icon(Icons.calendar_today)),
                ElevatedButton(
                    onPressed: () {
                      print(dueDate);
                      if (dueDate != null) {
                        context
                            .read<AssignmentBloc>()
                            .add(createAssignmentEvent(
                              newAssignment: assignment(
                                classroom_id: classRoomIdController.text,
                                teacher_id: teacherIdController.text,
                                subject_id: subjectIdController.text,
                                assignment_id: assignmentIdController.text,
                                assignment_name: assignmentTitleController.text,
                                assignment_description:
                                    descriptionController.text,
                                assignment_file: fileUrlController.text,
                                assignment_deadline: dueDate!,
                                created_date: DateTime.now(),
                              ),
                              classroom_id: classRoomIdController.text,
                              teacher_id: teacherIdController.text,
                            ));
                      } else {
                        // Handle the case when the assigned date is not selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select the assigned date"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit")),
              ],
            )),
          );
        }));
  }
}
