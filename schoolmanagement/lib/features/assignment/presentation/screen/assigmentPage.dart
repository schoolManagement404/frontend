import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';

class assignmentPage extends StatefulWidget {
  const assignmentPage({super.key});

  @override
  State<assignmentPage> createState() => _assignmentPageState();
}

class _assignmentPageState extends State<assignmentPage> {
  assignmentApi? assignment;
  String? classRoomId;
  String? student_id;
  @override
  Widget build(BuildContext context) {
    context.read<AssignmentBloc>().add(fetchAssignmentEvent(
        student_id: 'loggedInHive().getStudentId().toString()'));
    return BlocConsumer<AssignmentBloc, AssignmentState>(
        listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
            context: context, text: state.message ?? "Please wait a moment");
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is assignmentErrorState) {
        return Scaffold(
          body: Center(
            child: Text("Error ${state.message!}"),
          ),
        );
      } else if (state is assignmentLoadedState) {
        return Scaffold(
          body: ListView.builder(
            itemCount: state.assignmentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.assignmentList[index].assignment_name),
                subtitle:
                    Text(state.assignmentList[index].assignment_description),
              );
            },
          ),
        );
      } else {
        return const Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      }
    });
  }
}
