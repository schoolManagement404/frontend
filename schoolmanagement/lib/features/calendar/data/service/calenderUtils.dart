// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../model/event.dart';

/// Example event class.

// TODO: To add the data from backend and implement using bloc
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
    DateTime(2023, 11, 17): [Event("New")],
    DateTime(2023, 11, 13): [Event("gg"), Event("mm")],
    DateTime(2023, 11, 18): [Event("gg"), Event("mm"), Event("xs")],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final _holidays = {
  DateTime.utc(2023, 11, 13),
  DateTime.utc(2023, 11, 22),
  DateTime.utc(2023, 11, 23),
  DateTime.utc(2023, 7, 4),
};
bool isHoliday(DateTime day) {
  return _holidays.contains(day);
}

final _today = DateTime.now();
final firstDay = DateTime(_today.year - 3, _today.month, _today.day);
final lastDay = DateTime(_today.year + 3, _today.month, _today.day);
