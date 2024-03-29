import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/config/routes/routes.dart';
import 'package:schoolmanagement/core/notifications/firebase_api.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/auth/auth_page.dart';
import 'package:schoolmanagement/features/calendar/bloc/calendar_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';
import 'package:schoolmanagement/features/timeline/bloc/timeline/timeline_bloc.dart';
import 'package:schoolmanagement/injector.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SchoolManagement extends StatelessWidget {
  const SchoolManagement({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: "/",
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: serviceLocator<AuthBloc>()),
          BlocProvider<NavigationBloc>.value(
              value: serviceLocator<NavigationBloc>()),
          BlocProvider<AssignmentBloc>.value(
              value: serviceLocator<AssignmentBloc>()),
          BlocProvider<FeeBloc>.value(value: serviceLocator<FeeBloc>()),
          BlocProvider<ProfileBloc>.value(value: serviceLocator<ProfileBloc>()),
          BlocProvider<NoticeBloc>.value(value: serviceLocator<NoticeBloc>()),
          BlocProvider<CalendarBloc>.value(
              value: serviceLocator<CalendarBloc>()),
          BlocProvider<TimelineBloc>.value(
              value: serviceLocator<TimelineBloc>()),
        ],
        child: const AuthPage(),
      ),
    );
  }
}
