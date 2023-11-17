import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schoolmanagement/features/calendar/data/model/calendar.dart';

class CalendarApi {
  //funtion to get all calendar
  Future<List<CalendarModel>> getCalendarEvents() async {
    try {
      // Get all calendar from the server
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/students/calendar'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        print(jsonData);
        return (jsonData).map((json) => CalendarModel.fromJson(json)).toList();
      } else {
        // If response is not ok, throw an exception
        throw Exception('Error Status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      print('Error while fetching calendar: $e');
      throw Exception('Failed to fetch calendar: $e');
    }
  }
}
