import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/features/notices/data/model/noticeModel.dart';
import 'package:schoolmanagement/features/notices/presentation/screens/notice_details_page.dart';

class NoticeCard extends StatelessWidget {
  final Notice noticeModel;

  const NoticeCard({super.key, required this.noticeModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NoticeDetails(noticeModel: noticeModel)));
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${noticeModel.publishedDate}',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 10)),
            ),
            const SizedBox(height: 5,),
            Text(
              "${noticeModel.noticeTitle} ",
              style: GoogleFonts.inter(
                  textStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5,),
            Text(noticeModel.noticeDescription!.length > 150
                ? "${noticeModel.noticeDescription!.substring(0, 150)}..."
                : "${noticeModel.noticeDescription}")
          ],
        ),
      ),
    );
  }
}
