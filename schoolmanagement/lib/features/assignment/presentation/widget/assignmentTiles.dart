import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assignmentDetails.dart';
import 'package:schoolmanagement/features/assignment/presentation/widget/assignmentWidgets.dart';

class AssignmentTiles extends StatelessWidget {
  final assignment assignmentModel;
  const AssignmentTiles({super.key, required this.assignmentModel});

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
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
                onTap: () {
                  //navigate to the details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignmentDetailPage(
                        currentAssignment: assignmentModel,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: secondaryColor,
                          child: Icon(
                            Icons.assignment,
                            color: backgroundColor,
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                assignmentModel.assignment_name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: spaceCadet,
                                  package: AutofillHints.addressCity,
                                ),
                              ),
                              Gap(10),
                              Text(
                                assignmentModel.subject_id,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                assignmentModel.assignment_deadline
                                    .toIso8601String()
                                    .split("T")[0]
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
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
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
