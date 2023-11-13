import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentTiles.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';

class assignmentPage extends StatelessWidget {
  const assignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssignmentBloc>().add(fetchAssignmentEvent(
        userId: json.decode(loggedInHive().getLoginInfo())["data"]["student"]
            ["student_id"]));
    print(loggedInHive().getLoginInfo());
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
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            // scrolledUnderElevation: 0,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: const Text("Assignments",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: ListView.builder(
              prototypeItem: AssignmentTiles(
                assignmentModel: assignment(
                    assignment_id: "1",
                    assignment_name: "Assignment 1",
                    subject_id: "Maths",
                    classroom_id: '',
                    teacher_id: '',
                    assignment_description: '',
                    assignment_file: '',
                    assignment_deadline: DateTime.now(),
                    created_date: DateTime.now()),
              ),
              cacheExtent: 10,
              itemCount: state.assignmentList.length,
              itemBuilder: (context, index) {
                return AssignmentTiles(
                  assignmentModel: state.assignmentList[index],
                );
              },
            ),
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
