import 'package:dio/dio.dart';
import 'package:schoolmanagement/features/calendar/data/service/api_service.dart';

class CalendarRepository {
  getEvents() async {
    final dio = Dio();
    final response = await CalendarApi(dio).getEvents("");
    return response;
  }
}
