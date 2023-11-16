import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/model/noticeModel.dart';

class NoticeApi {
  //funtion to get all Notices
  Future<List<Notice>> getNotices() async {
    try {
      // Get all Notices from the server
      const url = 'http://10.0.2.2:3000/globals/notices';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List<dynamic>;
        // If response is ok, then return a list of Notices
        return (jsonData).map((json) => Notice.fromJson(json)).toList();
      } else {
        print(response.statusCode);
        // If response is not ok, throw an exception
        throw Exception('Error status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching Notices: $e');
      throw Exception('Failed to fetch Notices: $e');
    }
  }

  //funtion to post Notice
  Future<List<Notice>> postNotice(Notice notice) async {
    try {
      final response =
          await http.post(Uri.parse('url'), body: jsonEncode(notice.toJson()));
      // If response is ok, then return a list of Notices
      if (response.statusCode == 201) {
        print('successfully posted');
        return getNotices(); //return all Notices
      } else {
        throw Exception('Failed to post Notice');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while posting Notice: $e');
      throw Exception('Failed to post Notice');
    }
  }
}
