import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';
import 'package:schoolmanagement/features/notices/data/model/noticeModel.dart';

class NoticeDetails extends StatelessWidget {
  final Notice noticeModel;
  const NoticeDetails({super.key, required this.noticeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(parentContext: context, location: "noticedetails"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(headerText: "Announcements", parentContext: context),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                DateFormat.yMMMMd()
                    .format(DateTime.parse(noticeModel.noticeDate!)),
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 13.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "${noticeModel.noticeTitle!} ",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 21.5, fontWeight: FontWeight.bold)),
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "${noticeModel.noticeDescription}",
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(fontSize: 15.5)),
              ),
            )
          ],
        ));
  }
}
