import 'package:flutter/material.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assignmentDetails.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentWidgets.dart';

class AssignmentTiles extends StatefulWidget {
  final assignment assignmentModel;
  const AssignmentTiles({super.key, required this.assignmentModel});

  @override
  State<AssignmentTiles> createState() => _AssignmentTilesState();
}

class _AssignmentTilesState extends State<AssignmentTiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white70,
          child: InkWell(
              onTap: () {
                //navigate to the details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssignmentDetailPage(
                      currentAssignment: widget.assignmentModel,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.assignmentModel.assignment_name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.assignmentModel.subject_id,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.assignmentModel.assignment_deadline
                                .toIso8601String()
                                .split("T")[0]
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SuffixIconButton(
                        icon: Icons.arrow_forward_ios_outlined,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
