import 'package:flutter/material.dart';
import 'package:schoolmanagement/features/notices/data/model/noticeModel.dart';

class NoticeDetails extends StatelessWidget {
  final Notice noticeModel;
  const NoticeDetails({super.key, required this.noticeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noticeModel.noticeTitle!),
      ),
      body: Center(
        child: Text(noticeModel.noticeDescription!),
      ),
    );
  }
}
