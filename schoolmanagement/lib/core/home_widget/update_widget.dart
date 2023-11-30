import 'package:home_widget/home_widget.dart';
import 'package:schoolmanagement/core/constants/constant.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';

void updateAssignment(assignment newAssignment) {
  String assignments = newAssignment.assignment_name + "/?" + "Assignment 2";
  HomeWidget.saveWidgetData<String>(
      'headline_title', newAssignment.assignment_name);
  HomeWidget.saveWidgetData<String>(
      'headline_description', newAssignment.assignment_description);
  HomeWidget.saveWidgetData<String>('assignments', assignments);
  HomeWidget.updateWidget(
    iOSName: iosWidgetName,
    androidName: androidWidgetName,
  );
}
