import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/core/Error/404_page.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/addAssignmentPage.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assignmentPage.dart';
import 'package:schoolmanagement/features/auth/auth_page.dart';
import 'package:schoolmanagement/features/calendar/bloc/calendar_bloc.dart';
import 'package:schoolmanagement/features/calendar/presentation/screens/calenderPage.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/fee/presentation/screens/fee_page.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/notices/presentation/screens/noticesPage.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';
import 'package:schoolmanagement/features/profile/presentation/profile.dart';
import 'package:schoolmanagement/features/timeline/bloc/timeline/timeline_bloc.dart';
import 'package:schoolmanagement/features/timeline/presentation/screen/timeline.dart';

import '../../auth/authService/mongodbAuthProvider.dart';
import '../../features/assignment/bloc/assignment_bloc.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(
          settings,
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(mongoDBAuth()),
            child: const AuthPage(),
          ),
        );
      case '/calendar':
        return _materialRoute(
          settings,
          BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc(),
            child: const CalenderPage(),
          ),
        );
      case '/view_assignments':
        return _materialRoute(
          settings,
          BlocProvider<AssignmentBloc>(
            create: (context) => AssignmentBloc(),
            child: const assignmentPage(),
          ),
        );
      case '/add_assignment':
        return _materialRoute(
          settings,
          BlocProvider<AssignmentBloc>(
            create: (context) => AssignmentBloc(),
            child: const addAssignment(),
          ),
        );

      case '/fee':
        return _materialRoute(
          settings,
          BlocProvider<FeeBloc>(
            create: (context) => FeeBloc(),
            child: const FeePage(),
          ),
        );

      case '/profile':
        return _materialRoute(
            settings,
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(),
              child: const ProfilePage(),
            ));

      case '/notices':
        return _materialRoute(
          settings,
          BlocProvider<NoticeBloc>(
            create: (context) => NoticeBloc(),
            child: const noticePage(),
          ),
        );

      case '/timeline':
        return _materialRoute(
          settings,
          BlocProvider<TimelineBloc>(
            create: (context) => TimelineBloc(),
            child: const TimelinePage(),
          ),
        );

      case '/calender':
        return _materialRoute(
          settings,
          const CalenderPage(),
        );
      default:
        return _materialRoute(settings, const NotFound());
    }
  }

  static Route<dynamic> _materialRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
