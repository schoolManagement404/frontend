part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentEvent {}

class fetchAssignmentEvent extends AssignmentEvent {
  final String student_id;

  fetchAssignmentEvent({
    required this.student_id,
  });
}

class createAssignmentEvent extends AssignmentEvent {
  final assignment newAssignment;
  final String teacher_id;
  final String classroom_id;
  createAssignmentEvent({
    required this.teacher_id,
    required this.classroom_id,
    required this.newAssignment,
  });
}
