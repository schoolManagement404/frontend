import 'package:flutter/material.dart';
import 'package:schoolmanagement/features/calendar/presentation/widget/button/primary_button.dart';

class CalendarHome extends StatefulWidget {
  const CalendarHome({super.key});

  @override
  State<CalendarHome> createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  @override
  Widget build(BuildContext context) {
    return Center(child: primaryButton(sampleFunction(context), 'Click Me'));
  }

  sampleFunction(BuildContext context) {
    return () {
      Navigator.pushNamed(context, '/404');
    };
  }
}
