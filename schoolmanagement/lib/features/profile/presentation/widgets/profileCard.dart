import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(33, 35, 38, 0.1),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: -8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.5)),
                  ),
                  Text(
                    "${userData["name"]}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5)),
                  ),
                  Text(
                    "Roll No",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.5)),
                  ),
                  Text(
                    "${userData["roll_no"]}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5)),
                  ),
                  
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Class",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.5)),
                  ),
                  Text(
                    "${userData["class"]}",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5)),
                  ),
                  Text(
                    "Section",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 13.5)),
                  ),
                  Text(
                    "B",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5)),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://wallpapers.com/images/hd/profile-picture-f67r1m9y562wdtin.jpg'))),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'id: ',
                        ),
                        TextSpan(
                          text: '${userData["student_id"]}',
                          style: GoogleFonts.inter(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
