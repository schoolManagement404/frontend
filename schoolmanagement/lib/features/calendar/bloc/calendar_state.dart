part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {
  final bool isLoading;
  final String? message;
  final DateTime? focusedDate;
  final DateTime? selectedDate;
  final ValueNotifier<List<Event>>? selectedEvents;
  const CalendarState({
    this.focusedDate,
    this.selectedEvents,
    this.selectedDate,
    required this.isLoading,
    this.message,
  });
}

class CalendarInitialState extends CalendarState {
  const CalendarInitialState({required super.isLoading, super.message});
}

class CalendarErrorState extends CalendarState {
  final Exception? exception;
  const CalendarErrorState({
    required super.isLoading,
    required this.exception,
    required super.message,
  });
}

class CalendarLoadedState extends CalendarState {
  final List<CalendarModel> calendarData;
  const CalendarLoadedState({
    super.selectedEvents,
    super.selectedDate,
    required super.focusedDate,
    required super.isLoading,
    required this.calendarData,
  });

  CalendarLoadedState copyWith({
    bool? isLoading,
    DateTime? focusedDate,
    ValueNotifier<List<Event>>? selectedEvents,
    DateTime? selectedDate,
    List<CalendarModel>? calendarData,
  }) {
    return CalendarLoadedState(
        selectedEvents: selectedEvents ?? this.selectedEvents,
        focusedDate: focusedDate ?? this.focusedDate,
        selectedDate: selectedDate ?? this.selectedDate,
        isLoading: isLoading ?? this.isLoading,
        calendarData: calendarData ?? this.calendarData);
  }
}
