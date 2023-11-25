import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/notices/data/model/noticeModel.dart';

class NoticeDetails extends StatelessWidget {
  final Notice noticeModel;
  const NoticeDetails({super.key, required this.noticeModel});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: CustomAppBar(parentContext: context),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(headerText: "Announcements", parentContext: context),
              SizedBox(height: 20,),
              Text(
                "${noticeModel.publishedDate}",
                style: GoogleFonts.inter(
                    textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.5)),
              ),
              Text(
                "${noticeModel.noticeTitle!} ",
                style: GoogleFonts.inter(
                    textStyle:
                        TextStyle(fontSize: 21.5, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 40,),
              Text(
                  "${noticeModel.noticeDescription}",
                      style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 15.5)),)
            ],
          ),
        ));
  }
}
