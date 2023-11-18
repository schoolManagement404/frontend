import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/notices/presentation/notice_details_page.dart';

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
          return Scaffold(
            appBar: CustomAppBar(
              parentContext: context,
              isnotice: false,
            ),
            body: ListView.builder(
              itemCount: state.noticeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoticeDetails(
                                      noticeModel: state.noticeList[index])));
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        'Notice for ${state.noticeList[index].noticeTitle}'),
                                    Text(
                                      '${state.noticeList[index].noticeDescription}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
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
