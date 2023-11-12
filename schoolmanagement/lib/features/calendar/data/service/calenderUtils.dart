// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
    DateTime(2023, 11, 12): [Event("New")],
    DateTime(2023, 11, 13): [Event("gg"), Event("mm")],
    DateTime(2023, 11, 18): [Event("gg"), Event("mm"), Event("xs")],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final _kHolidays = {
  DateTime.utc(2023, 11, 13),
  DateTime.utc(2023, 11, 22),
  DateTime.utc(2023, 11, 23),
  DateTime.utc(2023, 7, 4),
};
bool isHoliday(DateTime day) {
  return _kHolidays.contains(day);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 3, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 3, kToday.month, kToday.day);
