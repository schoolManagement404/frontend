import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<firebase_storage.UploadTask> uploadFile(File file) async {
  firebase_storage.UploadTask uploadTask;
  String exactFile = file.uri.pathSegments.last;
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('assignments')
      .child(exactFile);

  final metadata = firebase_storage.SettableMetadata(
      contentType: 'file/pdf', customMetadata: {'picked-file-path': file.path});

  uploadTask = ref.putData(await file.readAsBytes(), metadata);

  return Future.value(uploadTask);
}
