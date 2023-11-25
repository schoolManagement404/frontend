import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/notices/presentation/widgets/noticeButton.dart';
import 'package:schoolmanagement/features/notices/presentation/widgets/noticeTile.dart';

class noticePage extends StatelessWidget {
  const noticePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NoticeBloc>().add(const fetchNoticeEvent());
    return BlocConsumer<NoticeBloc, NoticeState>(
      listener: (BuildContext context, NoticeState state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context, text: state.message ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (BuildContext context, NoticeState state) {
        print(state);
        if (state is NoticeErrorState) {
          return Scaffold(
            body: Center(
              child: Text("Error ${state.message!}"),
            ),
          );
        } else if (state is NoticeLoadedState) {
          // state.noticeList[index]
          return Scaffold(
            appBar: CustomAppBar(parentContext: context),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Announcements",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      NoticeButton(title: "Today", color: Colors.grey),
                      SizedBox(
                        width: 10,
                      ),
                      NoticeButton(title: "This Week", color: Colors.black),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.noticeList.length,
                      itemBuilder: (BuildContext contex, int index) {
                        return Column(
                          children: [
                            NoticeCard(noticeModel: state.noticeList[index],),
                            Divider(
                              thickness: 1.5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is NoticeEmptyState) {
          return const Scaffold(
            body: Center(
              child: Text("No notices found"),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        }
      },
    );
  }
}
