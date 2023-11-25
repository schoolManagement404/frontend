import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentTiles.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';

class assignmentPage extends StatelessWidget {
  const assignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AssignmentBloc>().add(fetchAssignmentEvent(
        userId: json.decode(loggedInHive().getLoginInfo())["data"]["student"]
            ["student_id"]));
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        parentContext: context,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Assignments',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<AssignmentBloc>().add(fetchAssignmentEvent(
                    userId: json.decode(loggedInHive().getLoginInfo())["data"]
                        ["student"]["student_id"]));
              },
              child: BlocBuilder<AssignmentBloc, AssignmentState>(
                builder: (context, state) {
                  if (state is assignmentLoadedState) {
                    return ListView.builder(
                      itemCount: state.assignmentList.length,
                      itemBuilder: (context, index) {
                        final assignment assignmentModel =
                            state.assignmentList[index];
                        return AssignmentTiles(
                          assignmentModel: assignmentModel,
                        );
                      },
                    );
                  } else if (state is assignmentErrorState) {
                    return const Center(
                      child: Text("Error while getting assignments"),
                    );
                  } else if (state is assignmentInitialState) {
                    return const Center(
                      //replace with skeleton
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("No assignments found"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//   
