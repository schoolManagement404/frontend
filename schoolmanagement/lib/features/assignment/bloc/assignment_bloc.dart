import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/features/assignment/data/model/assignment.dart';
import 'package:schoolmanagement/features/assignment/data/service/assignmentApiService.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  Future<firebase_storage.UploadTask> uploadFile(File file) async {
    firebase_storage.UploadTask uploadTask;
    try {
      // Create a Reference to the file
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('assignmentFiles')
          .child('/some-file.pdf');

      final metadata = firebase_storage.SettableMetadata(
          contentType: 'file/pdf',
          customMetadata: {'picked-file-path': file.path});
      print("Uploading..!");

      uploadTask = ref.putData(await file.readAsBytes(), metadata);
      print('done');
      return Future.value(uploadTask);
    } catch (e) {
      print('error: ${e.toString()}');
      throw Error();
    }
  }

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

    // ***For File Picker*** (not used now)
    on<selectFilesEvent>((event, emit) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      print("Result= ${result}");
      if (result != null) {
        final File _selectedFile = File(result.paths[0]!);

        emit(selectFilesState(file: _selectedFile, isLoading: false));
      } else {
        // User canceled the picker
      }
    });

    // uploading assignment for teacher
    on<createAssignmentEvent>((event, emit) async {
      emit(const assignmentInitialState(isLoading: true));
      try {
        AssignmentApi assignmentApi = AssignmentApi();
        await assignmentApi.postAssignment(event.newAssignment);
        await uploadFile(event.toUploadFile!);
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
