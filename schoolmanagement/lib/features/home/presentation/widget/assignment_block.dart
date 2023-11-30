import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanagement/core/hiveLocalDB/loggedInState/loggedIn.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';

import '../../../assignment/data/model/assignment.dart';

class AssignmentBlock extends StatefulWidget {
  const AssignmentBlock({super.key});

  @override
  State<AssignmentBlock> createState() => _AssignmentBlockState();
}

class _AssignmentBlockState extends State<AssignmentBlock> {
  bool showAllAssignment = false;
  @override
  Widget build(BuildContext context) {
    context.read<AssignmentBloc>().add(fetchAssignmentEvent(
        userId: json.decode(loggedInHive().getLoginInfo())["data"]["student"]
            ["student_id"]));
    return RefreshIndicator(
        onRefresh: () async {
          fetchAssignments(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "YOUR ASSIGNMENTS",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 21.5, fontWeight: FontWeight.bold)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showAllAssignment = !showAllAssignment;
                      });
                    },
                    child: Text(
                      showAllAssignment ? "Show less" : "See all",
                      style:
                          GoogleFonts.inter(textStyle: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              BlocBuilder<AssignmentBloc, AssignmentState>(
                builder: (context, state) {
                  if (state is assignmentInitialState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is assignmentErrorState) {
                    return Center(
                      child: Column(children: [
                        Text(
                            "failed to get assignments!\n Check the internet connection"),
                        ElevatedButton(
                            onPressed: () async {
                              fetchAssignments(context);
                            },
                            child: Text("Retry"))
                      ]),
                    );
                  } else if (state is assignmentLoadedState) {
                    state.assignmentList.sort((a, b) {
                      return b.assignment_deadline
                          .compareTo(a.assignment_deadline);
                    });

                    List<assignment> displayedAssignments;

                    if (showAllAssignment) {
                      displayedAssignments = state.assignmentList;
                    } else {
                      displayedAssignments =
                          state.assignmentList.take(2).toList();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: displayedAssignments.length,
                      itemBuilder: (context, index) {
                        final assignment assignmentModel =
                            displayedAssignments[index];
                        return AssignmentCard(assignmentModel: assignmentModel);
                      },
                    );
                  } else {
                    return Center(child: Text("No assignments found"));
                  }
                },
              ),
            ],
          ),
        ));
  }

  void fetchAssignments(BuildContext context) {
    context.read<AssignmentBloc>().add(fetchAssignmentEvent(
        userId: json.decode(loggedInHive().getLoginInfo())["data"]["student"]
            ["student_id"]));
  }
}

class AssignmentCard extends StatelessWidget {
  final assignment assignmentModel;

  const AssignmentCard({super.key, required this.assignmentModel});

  @override
  Widget build(BuildContext context) {
    final deadlineDate = assignmentModel.assignment_deadline;
    final todayDate = DateTime.now();
    final remainingDays = DateTime.now().isAfter(deadlineDate)
        ? 0
        : deadlineDate.difference(todayDate).inDays;
    ;

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        height: 119,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Color(0xFFFFB2B2))),
        child: Row(
          children: [
            Container(
              width: 146,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gap(6),
                  Text(
                    "${assignmentModel.subject_id}",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 16.5,
                          color: Color(0xFF637EB5),
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(height: 30, color: Color(0xFFFFB2B2))
                ],
              ),
            ),
            Container(width: 2, height: 119, color: Color(0xFFFFB2B2)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deadline",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF808080),
                          )),
                        ),
                        Text(
                          DateFormat('yyyy MMM dd').format(
                              assignmentModel.assignment_deadline.toLocal()),
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF3B3B3B),
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "${assignmentModel.assignment_name}",
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 14.5,
                              color: Color(0xFF637EB5),
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${assignmentModel.teacher_id}",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 11.5, color: Colors.black)),
                        ),
                        Text(
                          "${remainingDays} days left",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF3B3B3B),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
