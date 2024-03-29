// ignore_for_file: camel_case_types, non_constant_identifier_names

part of 'assignment_bloc.dart';

@immutable
abstract class AssignmentState {
  final bool isLoading;
  final String? message;

  const AssignmentState({required this.isLoading, this.message});
}

class assignmentInitialState extends AssignmentState {
  const assignmentInitialState({required super.isLoading});
}

class assignmentLoadedState extends AssignmentState {
  final List<assignment> assignmentList;
  const assignmentLoadedState({
    required this.assignmentList,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class assignmentErrorState extends AssignmentState {
  final Exception? exception;
  const assignmentErrorState({
    required this.exception,
    required message,
    required isLoading,
  }) : super(isLoading: isLoading, message: message);
}

class dueDateAddedState extends AssignmentState {
  final DateTime? dueDate;
  const dueDateAddedState({
    required this.dueDate,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class selectClassroomState extends AssignmentState {
  final String classroom_id;
  const selectClassroomState({
    required this.classroom_id,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class selectFilesState extends AssignmentState {
  final File file;
  const selectFilesState({
    required this.file,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class FileSelectedState extends AssignmentState {
  final File file;
  const FileSelectedState({
    required this.file,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class FileSelectedErrorState extends AssignmentState {
  final File file;
  const FileSelectedErrorState({
    required this.file,
    required isLoading,
    required message,
  }) : super(isLoading: isLoading, message: message);
}

class assignmentAddState extends AssignmentState {
  const assignmentAddState({
    required isLoading,
  }) : super(isLoading: isLoading);
}
