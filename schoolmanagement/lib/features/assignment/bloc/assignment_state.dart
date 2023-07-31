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

class assignmentAddState extends AssignmentState {
  const assignmentAddState({
    required isLoading,
  }) : super(isLoading: isLoading);
}
