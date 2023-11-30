import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NoticeBloc>().add(fetchNoticeEvent());
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NoticeBloc>().add(fetchNoticeEvent());
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF9F9FC),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset("assets/images/notice.png"))),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: 179,
                  child: BlocBuilder<NoticeBloc, NoticeState>(
                    builder: (context, state) {
                      if (state is NoticeInitial) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NoticeErrorState) {
                        return Center(
                          child: Text(
                              "There was an error .\n Try checking your internrt connection"),
                        );
                      } else if (state is NoticeLoadedState) {

                        state.noticeList.sort((a, b) {
                          return b.noticeDate!.compareTo(a.noticeDate!);
                        });

                        String formattedDate = DateFormat('yyyy MMM dd').format(
                            DateTime.parse(state.noticeList[1].publishedDate!)
                                .toLocal());

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NOTICE BOARD",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: 21.5,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${state.message}".length >= 100
                                  ? "${state.message}".substring(0, 100)
                                  : "${state.message}",
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF808080),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Posted: ${formattedDate}",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(fontSize: 11.5)),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("No notice found"),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
