import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/add_assignment_file_firebase_api.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';
part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentBloc() : super(const assignmentInitialState(isLoading: false)) {
    // for fetching assignments for student.
    on<fetchAssignmentEvent>((event, emit) async {
      emit(const assignmentInitialState(isLoading: true));
      try {
        AssignmentApi assignmentApi = AssignmentApi();
        final List<assignment> assignments =
            await assignmentApi.getAllAssignment(userId: event.userId);
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

    on<selectFilesEvent>((event, emit) async {
      final path = await FlutterDocumentPicker.openDocument();
      File file = File(path!);
      // firebase_storage.UploadTask task = await uploadFile(file);
      // print(task);
      emit(FileSelectedState(file: file, isLoading: false));
    });

    // uploading assignment for teacher
    on<createAssignmentEvent>((event, emit) async {
      emit(const assignmentInitialState(isLoading: true));
      try {
        AssignmentApi assignmentApi = AssignmentApi();
        await assignmentApi.postAssignment(event.newAssignment);
        // await uploadFile(event.toUploadFile);
        uploadFile(event.toUploadFile!);
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
