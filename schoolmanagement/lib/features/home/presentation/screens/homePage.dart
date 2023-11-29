import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/calendar/bloc/calendar_bloc.dart';
import 'package:schoolmanagement/features/calendar/data/model/event.dart';
import 'package:schoolmanagement/features/calendar/data/service/calenderUtils.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';
import 'package:table_calendar/table_calendar.dart';

// import '../../../../core/hiveLocalDB/loggedInState/loggedIn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _today = DateTime.now();
    final firstDay = DateTime(_today.year - 3, _today.month, _today.day);
    final lastDay = DateTime(_today.year + 3, _today.month, _today.day);

    context.read<CalendarBloc>().add(fetchCalendarDataEvent());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: CustomAppBar(
            parentContext: context,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(json.decode(loggedInHive().getLoginInfo()).toString()),
                BlocBuilder<CalendarBloc, CalendarState>(
                    builder: (context, state) {
                  if (state is CalendarLoadedState) {
                    return TableCalendar<Event>(
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
                            selectedDate: selectedDay,
                            focusedDate: focusedDay));
                      },
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
                    );
                  } else if (state is CalendarErrorState) {
                    return Text("Calendar Error");
                  } else {
                    return Text("Calendar Initial");
                  }
                }),
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    child: const Text("Logout")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/view_assignments");
                    },
                    child: const Text("Assignment")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_assignment");
                    },
                    child: const Text("Add Assignment")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/fee");
                    },
                    child: const Text("Fee")),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/timeline");
                      },
                      child: const Text("Timeline"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/notices");
                        },
                        child: const Text("Notice")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/calendar");
                        },
                        child: const Text("calender"))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
