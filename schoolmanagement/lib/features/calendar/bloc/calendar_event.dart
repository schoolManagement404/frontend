part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}

class fetchCalendarDataEvent extends CalendarEvent {}

class dateSelectedEvent extends CalendarEvent {
  final DateTime? selectedDate;
  final DateTime? focusedDate;
  late final ValueNotifier<List<Event>>? selectedEvents;
  dateSelectedEvent(
      {this.focusedDate, this.selectedEvents, required this.selectedDate});
}
