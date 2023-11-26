import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schoolmanagement/features/timeline/data/routine.dart';

class TimeCard extends StatelessWidget {
  final Routine routine;
  const TimeCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    //12 hr format

    String hr_12_format_start = routine.startTime.toLocal().hour > 12
        ? (routine.startTime.toLocal().hour - 12).toString()
        : routine.startTime.toLocal().hour.toString();
    DateTime endTime = routine.startTime.add(Duration(hours: routine.length));
    String hr_12_format_end = endTime.toLocal().hour > 12
        ? (endTime.toLocal().hour - 12).toString()
        : endTime.toLocal().hour.toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$hr_12_format_start:00 - $hr_12_format_end:00',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          Gap(15),
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
