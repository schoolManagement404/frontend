import 'package:flutter/material.dart';
import 'package:schoolmanagement/app.dart';
import 'package:schoolmanagement/initial_setup.dart';

void main() async {
  await init();
  runApp(const SchoolManagement());
}
