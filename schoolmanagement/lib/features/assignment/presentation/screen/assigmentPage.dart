import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';

import 'assignmentDetails.dart';

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
          body: ListView.builder(
            itemCount: state.assignmentList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.assignmentList[index].assignment_name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(state.assignmentList[index].subject_id),
                trailing: Column(
                  children: [
                    Text("Due Date:"),
                    Text(state.assignmentList[index].assignment_deadline
                        .toIso8601String()
                        .split("T")[0]
                        .toString()),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignmentDetailPage(
                        currentAssignment: state.assignmentList[index],
                      ),
                    ),
                  );
                },
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
