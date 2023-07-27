import 'package:flutter/material.dart';
import 'package:schoolmanagement/core/Error/404_page.dart';
import 'package:schoolmanagement/features/calendar/presentation/screens/home/home_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(settings, const CalendarHome());
      default:
        return _materialRoute(settings, const NotFound());
    }
  }

  static Route<dynamic> _materialRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
