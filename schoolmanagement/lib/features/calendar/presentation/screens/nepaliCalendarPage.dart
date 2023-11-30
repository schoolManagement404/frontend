import 'package:flutter/material.dart';
import 'package:flutter_bs_ad_calendar/flutter_bs_ad_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class NepaliCalendarPage extends StatefulWidget {
  const NepaliCalendarPage({super.key});

  @override
  State<NepaliCalendarPage> createState() => _NepaliCalendarPageState();
}

class Content {
  String? title;

  Content({
    this.title,
  });
}

class _NepaliCalendarPageState extends State<NepaliCalendarPage> {
  DateTime? _selectedDate;
  List<Event>? _events;
  ValueNotifier<List<Event>> _selectedDateEvents =
      ValueNotifier<List<Event>>([]);
  CalendarType? _calendarType;
  List<Event> _getEvents() {
    return [
      Event(
        date: DateTime(2023, 04, 14),
        event: Content(title: 'Event'),
      ),
      Event(
        date: DateTime(2023, 04, 16),
        event: Content(title: 'Event 01'),
      ),
      Event(
        date: DateTime(2023, 05, 01),
        event: Content(title: 'Event 02'),
      ),
      Event(
        date: DateTime(2023, 05, 14),
        event: Content(title: 'Event 03'),
      ),
      Event(
        date: DateTime(2023, 05, 26),
        event: Content(title: 'Event 04'),
      ),
      Event(
        date: DateTime(2023, 05, 29),
        event: Content(title: 'Event 05'),
      ),
      Event(
        date: DateTime(2023, 07, 21),
        event: Content(title: 'Event 06'),
      ),
      Event(
        date: DateTime(2023, 11, 29),
        event: Content(title: 'Event 07'),
      ),
      Event(
        date: DateTime(2023, 11, 30),
        event: Content(title: 'Event 08'),
      ),
      Event(
        date: DateTime(2023, 11, 30),
        event: Content(title: 'Event 09'),
      ),
    ];
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Filter events for the given day
    return _getEvents().where((event) => isSameDay(event.date, day)).toList();
  }

  @override
  void initState() {
    super.initState();
    _calendarType = CalendarType.bs;
    _selectedDateEvents = ValueNotifier(_getEventsForDay(DateTime.now()));
    _events = _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_calendarType == CalendarType.ad) {
                setState(() => _calendarType = CalendarType.bs);
              } else {
                setState(() => _calendarType = CalendarType.ad);
              }
            },
            child: Text(_calendarType == CalendarType.bs ? 'En' : 'ने'),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: FlutterBSADCalendar(
              holidays: [DateTime(2023, 11, 30), DateTime(2023, 11, 29)],
              calendarType: _calendarType!,
              holidayColor: Colors.red,
              weekendDays: const [DateTime.saturday],
              initialDate: DateTime.now(),
              firstDate: DateTime(1970),
              lastDate: DateTime(2024),
              eventColor: Colors.purple,
              events: _events,
              onDateSelected: (date, events) {
                setState(() {
                  _selectedDate = date;
                  _selectedDateEvents =
                      ValueNotifier<List<Event>>(events ?? []);
                });
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedDateEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value[index].event?.title ?? 'No Title'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
