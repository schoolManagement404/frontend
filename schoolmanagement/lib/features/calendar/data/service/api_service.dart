import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_service.g.dart';

//Replace with your own api address
@RestApi(baseUrl: "https://www.googleapis.com/calendar/v3/calendars")
abstract class CalendarApi {
  factory CalendarApi(Dio dio) = _CalendarApi;

  @GET("/primary/events")
  Future<HttpResponse> getEvents(@Query("key") String key);
}
