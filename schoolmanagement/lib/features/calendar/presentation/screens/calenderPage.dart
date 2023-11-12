import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          firstDay: DateTime(2019),
          lastDay: DateTime(2025),
          focusedDay: DateTime.now(),
          rangeStartDay: DateTime(2023, 11, 1),
          rangeEndDay: DateTime(2023, 11, 13),
          weekendDays: const [DateTime.saturday],
          daysOfWeekHeight: 30,
          headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          )),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            weekendStyle: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.red),
          ),
          calendarStyle: const CalendarStyle(
            weekendTextStyle: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            defaultTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            weekNumberTextStyle: TextStyle(fontSize: 20),
            holidayTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
