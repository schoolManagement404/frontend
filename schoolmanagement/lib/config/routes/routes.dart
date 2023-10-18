import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/404_page.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/addAssignmentPage.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assigmentPage.dart';
import 'package:schoolmanagement/features/calendar/presentation/screens/home/home_page.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/fee/presentation/screens/feePage.dart';

import '../../features/assignment/bloc/assignment_bloc.dart';
import '../../features/assignment/presentation/screen/assignmentDetails.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
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
            child: const feePage(),
          ),
        );
      default:
        return _materialRoute(settings, const NotFound());
    }
  }

  static Route<dynamic> _materialRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
