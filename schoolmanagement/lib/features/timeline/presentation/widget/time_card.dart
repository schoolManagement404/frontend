import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schoolmanagement/features/timeline/data/routine.dart';

class TimeCard extends StatelessWidget {
  final Routine routine;
  const TimeCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${routine.startTime.toLocal().hour.toString()} - ${routine.startTime.toLocal().add(Duration(hours: routine.length)).hour.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              // color: const Color(0xFFEFFFF0),
              color: routine.length == 1
                  ? const Color(0xFFFFB35B)
                  : const Color(0xFFEFFFF0),
              borderRadius: BorderRadius.circular(6.16),
              border: BorderDirectional(
                start: BorderSide(
                  color: routine.length == 1
                      ? const Color(0xFFFF1F11)
                      : const Color(0xFF94FF98),
                  width: 2,
                ),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      routine.subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(3),
                    Text(routine.teacher,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.black,
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
