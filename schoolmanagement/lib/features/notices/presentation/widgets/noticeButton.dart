import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeButton extends StatelessWidget {
  final String title;
  final Color color;

  const NoticeButton({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        height: 40,
        width: 106,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
