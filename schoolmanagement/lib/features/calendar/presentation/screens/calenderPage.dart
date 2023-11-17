// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/calendar/data/model/event.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/Error/loadingScreen/loadingScreen.dart';
import '../../bloc/calendar_bloc.dart';
import '../../data/service/calenderUtils.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  // late final ValueNotifier<List<Event>> _selectedEvents;
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  // List<Event> _getEventsForDay(DateTime day) {
  //   return kEvents[day] ?? [];
  // }

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   if (!isSameDay(_selectedDay, selectedDay)) {
  //     setState(() {
  //       _selectedDay = selectedDay;
  //       _focusedDay = focusedDay;
  //     });

  //     _selectedEvents.value = _getEventsForDay(selectedDay);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedDay = _focusedDay;
  //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  // }

  // @override
  // void dispose() {
  //   _selectedEvents.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    context.read<CalendarBloc>().add(fetchCalendarDataEvent());

    Future.delayed(Duration.zero, () {
      LoadingScreen().show(
        context: context,
        text: "Please wait a moment",
      );
    });

    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        if (state.isLoading) {
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is CalendarErrorState) {
          return Scaffold(
            body: Center(
              child: Text("Error ${state.message!}"),
            ),
          );
        } else if (state is CalendarLoadedState) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  TableCalendar<Event>(
                    firstDay: firstDay,
                    lastDay: lastDay,
                    focusedDay: state.focusedDate!,
                    holidayPredicate: (day) =>
                        context.read<CalendarBloc>().isHoliday(day),
                    weekendDays: const [DateTime.saturday],
                    daysOfWeekHeight: 30,
                    eventLoader: (day) =>
                        context.read<CalendarBloc>().getEventsForDay(day),
                    selectedDayPredicate: (day) {
                      return isSameDay(state.selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      context.read<CalendarBloc>().add(dateSelectedEvent(
                          selectedDate: selectedDay, focusedDate: focusedDay));
                    },
                    headerStyle: HeaderStyle(
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
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.red),
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
                        holidayTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                        holidayDecoration: BoxDecoration()),
                  ),
                  Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                          valueListenable: state.selectedEvents!,
                          builder: (context, value, _) {
                            return ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('${value[index]}'),
                                  );
                                });
                          }))
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
              body: Center(
            child: Text("no data"),
          ));
        }
      },
    );
  }
}
