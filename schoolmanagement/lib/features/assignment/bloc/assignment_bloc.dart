import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/core/allUser/student/studentModal.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(const assignmentInitialState(isLoading: false)) {
    // for fetching assignments for student.
    on<fetchAssignmentEvent>((event, emit) async {
      emit(const assignmentInitialState(isLoading: true));
      try {
        assignmentApi _assignmentApi = assignmentApi();
        final List<assignment> assignments =
            await _assignmentApi.getAllAssignment(userId: event.userId);
        if (assignments.isEmpty) {
          emit(assignmentErrorState(
              exception: Exception('No assignments found'),
              message: 'No assignments found',
              isLoading: false));
        } else {
          emit(assignmentLoadedState(
              assignmentList: assignments, isLoading: false));
        }
      } on Exception catch (e) {
        emit(assignmentErrorState(
            exception: e,
            message: 'Error while fetching assignments $e',
            isLoading: false));
      }
    });
    //setting due date for assignment for teacher
    on<dueDateAddedEvent>((event, emit) async {
      emit(dueDateAddedState(dueDate: event.dueDate, isLoading: false));
    });
    // selecting classroom for teacher
    on<selectClassroomEvent>((event, emit) async {
      emit(selectClassroomState(
          classroom_id: event.classroom_id, isLoading: false));
    });

    // ***For File Picker*** (not used now)
    // on<selectFilesEvent>((event, emit) async {
    //   FilePickerResult? result =
    //       await FilePicker.platform.pickFiles(allowMultiple: true);
    //   print("Result= ${result}");
    //   if (result != null) {
    //     final List<File> _selectedFiles =
    //         result.paths.map((path) => File(path!)).toList();
    //     emit(selectFilesState(files: _selectedFiles, isLoading: false));
    //   } else {
    //     // User canceled the picker
    //   }
    // });

    // uploading assignment for teacher
    on<createAssignmentEvent>((event, emit) async {
      emit(const assignmentInitialState(isLoading: true));
      try {
        assignmentApi _assignmentApi = assignmentApi();
        await _assignmentApi.postAssignment(event.newAssignment);

        emit(const assignmentAddState(
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(assignmentErrorState(
            exception: e,
            message: 'Error while posting assignments: $e',
            isLoading: false));
      }
    });
  }
}
