import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineBlock extends StatelessWidget {
  const RoutineBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TODAY CLASS",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 21.5, fontWeight: FontWeight.bold)),
                ),
                Text(
                  "Sun 26 Nov",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 16)),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child:SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                  RoutineCard(subject: "Database Management System", teacherName: "Rajani Chulayadyo", classTime: "7:00 AM", classRoom: "Room No. 10",),
                  SizedBox(width: 15,),
                  RoutineCard(subject: "Database Management System", teacherName: "Rajani Chulayadyo", classTime: "7:00 AM", classRoom: "Room No. 10",),
                  SizedBox(width: 15,),
                  RoutineCard(subject: "Database Management System", teacherName: "Rajani Chulayadyo", classTime: "7:00 AM", classRoom: "Room No. 10",),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoutineCard extends StatelessWidget {
  final String subject;
  final String classRoom;
  final String teacherName;
  final String classTime;

  const RoutineCard({super.key, required this.subject, required this.classRoom, required this.teacherName, required this.classTime});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 149,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FC),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(33, 35, 38, 0.1),
            offset: Offset(0, 10),
            blurRadius: 10,
            spreadRadius: -8,
          ),
        ],
        border: Border.all(width: 0.9, color: const Color(0xFFE9E8E8)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
         padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
         child: Column(
           children: [
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 const Icon(
                   Icons.access_time_outlined,
                   size: 15,
                 ),
                 const SizedBox(width: 5,),
                 Text(
                   classTime,
                   style: GoogleFonts.inter(
                       textStyle: const TextStyle(
                     fontSize: 9.5,
                     color: Color(0xFF64748B),
                   )),
                 ),
               ],
             ),
           const Divider(height: 9,color: Color(0xFFE9E8E8),),
          
             Text(
               subject,
               style: GoogleFonts.inter(
                   textStyle: const TextStyle(
                       fontSize: 12.5,
                       color: Color(0xFF64748B),
                       fontWeight: FontWeight.bold)),
             ),
             const SizedBox(
               height: 10,
             ),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 const Icon(
                   Icons.location_pin,
                   size: 15,
                 ),
                 const SizedBox(width: 5,),
                 Text(
                   classRoom,
                   style: GoogleFonts.inter(
                       textStyle: const TextStyle(
                     fontSize: 9.5,
                     color: Color(0xFF64748B),
                   )),
                 ),
               ],
             ),
             const SizedBox(
               height: 5,
             ),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 const CircleAvatar(
                     radius: 10, child: Icon(Icons.person, size: 10)),
                     const SizedBox(width: 5,),
                 Text(
                   teacherName,
                   style: GoogleFonts.inter(
                       textStyle: const TextStyle(
                     fontSize: 9.5,
                     color: Color(0xFF64748B),
                   )),
                 ),
               ],
             ),
           ],
         ),
       ),
    );
  }
}
