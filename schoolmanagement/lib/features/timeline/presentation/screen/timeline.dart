import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';
import 'package:schoolmanagement/features/timeline/bloc/timeline/timeline_bloc.dart';
import 'package:schoolmanagement/features/timeline/presentation/widget/time_card.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TimelineBloc>().add(fetchTimelineEvent(date: DateTime.now()));
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(parentContext: context),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            CustomHeader(headerText: "Timeline", parentContext: context),
            const Row(
              children: [
                DayButton(day: "Mon"),
                DayButton(day: "Tue"),
                DayButton(day: "Wed"),
                DayButton(day: "Thu"),
                DayButton(day: "Fri"),
                DayButton(day: "Sat"),
                DayButton(day: "Sun"),
              ],
            ),
            const Gap(5),
            const Gap(5),
            Expanded(
              child: BlocBuilder<TimelineBloc, TimelineState>(
                builder: (context, state) {
                  if (state is TimelineInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TimelineError) {
                    return Center(
                      child: Text(state.message ?? "Something went wrong"),
                    );
                  } else if (state is TimelineLoaded) {
                    return ListView.builder(
                        itemCount: state.routineList.length,
                        itemBuilder: (context, index) {
                          return TimeCard(
                            routine: state.routineList[index],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DayButton extends StatelessWidget {
  final String day;
  const DayButton({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: null,
        child: Material(
          elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: Colors.black,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                day,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
