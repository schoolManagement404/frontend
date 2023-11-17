// ignore_for_file: non_constant_identifier_names

import 'package:schoolmanagement/features/calendar/data/model/event.dart';

class CalendarModel {
  final List<String> event_name;
  final DateTime event_date;
  final bool is_holiday;

  CalendarModel({
    required this.event_name,
    required this.event_date,
    required this.is_holiday,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    // Convert the list of dynamic to list of strings

    List<String> eventNames = (json['event_name'] as List<dynamic>)
        .map((eventName) => eventName.toString())
        .toList();
    return CalendarModel(
      event_name: eventNames,
      event_date: DateTime.parse(json['event_date']),
      is_holiday: json['is_holiday'],
    );
  }
}
