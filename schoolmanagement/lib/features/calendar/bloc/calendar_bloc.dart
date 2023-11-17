import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:schoolmanagement/features/calendar/data/service/calendarApi.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:schoolmanagement/features/calendar/data/model/event.dart';
import '../data/model/calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  late ValueNotifier<List<Event>> _selectedEvents;
  late LinkedHashMap<DateTime, List<Event>> kEvents;
  List<Event> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  late Set<DateTime> holidays;
  bool isHoliday(DateTime day) {
    return holidays.contains(day);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  CalendarBloc() : super(const CalendarInitialState(isLoading: true)) {
    _selectedEvents = ValueNotifier([]);
    holidays = {};
    kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    on<fetchCalendarDataEvent>((event, emit) async {
      emit(const CalendarInitialState(isLoading: true, message: "Please Wait"));
      try {
        List<CalendarModel>? calendarData =
            await CalendarApi().getCalendarEvents();
        // remain
        for (var data in calendarData) {
          final date = data.event_date;
          final events = kEvents[date] ?? [];
          final isHoliday = data.is_holiday;

          // Convert List<String> to List<Event>
          final eventList =
              data.event_name.map((eventName) => Event(eventName)).toList();
          events.addAll(eventList);
          kEvents[date] = events;
          if (isHoliday) {
            holidays.add(date);
          }
        }

        emit(CalendarLoadedState(
          selectedEvents: ValueNotifier(getEventsForDay(DateTime.now())),
          focusedDate: DateTime.now(),
          isLoading: false,
          calendarData: calendarData,
        ));
      } on Exception catch (e) {
        emit(CalendarErrorState(
            isLoading: false,
            exception: e,
            message: "Error while fetching calendardata $e"));
      }
    });

    on<dateSelectedEvent>((event, emit) {
      if (state is CalendarLoadedState) {
        final currentState = state as CalendarLoadedState;
        if (!isSameDay(event.selectedDate, currentState.selectedDate)) {
          _selectedEvents.value = getEventsForDay(event.selectedDate!);

          emit(currentState.copyWith(
            selectedDate: event.selectedDate,
            focusedDate: event.focusedDate!,
            selectedEvents: _selectedEvents,
          ));
        }
      }
    });
  }
}
