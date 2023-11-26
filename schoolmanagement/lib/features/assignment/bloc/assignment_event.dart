// ignore_for_file: non_constant_identifier_names

part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentEvent {}

class fetchAssignmentEvent extends AssignmentEvent {
  final String userId;

  fetchAssignmentEvent({
    required this.userId,
  });
}

class dueDateAddedEvent extends AssignmentEvent {
  final DateTime? dueDate;
  dueDateAddedEvent({required this.dueDate});
}

class createAssignmentEvent extends AssignmentEvent {
  final assignment newAssignment;
  File? toUploadFile;
  final String teacher_id;
  final String classroom_id;
  createAssignmentEvent({
    this.toUploadFile,
    required this.teacher_id,
    required this.classroom_id,
    required this.newAssignment,
  });
}

class selectClassroomEvent extends AssignmentEvent {
  final String classroom_id;
  selectClassroomEvent({
    required this.classroom_id,
  });
}

class selectFilesEvent extends AssignmentEvent {
  selectFilesEvent();
}
