import 'package:get_it/get_it.dart';
import 'package:schoolmanagement/auth/authService/mongodbAuthProvider.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/calendar/bloc/calendar_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';
import 'package:schoolmanagement/features/timeline/bloc/timeline/timeline_bloc.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => AuthBloc(mongoDBAuth()));
  serviceLocator.registerLazySingleton(() => NavigationBloc());
  serviceLocator.registerLazySingleton(() => AssignmentBloc());
  serviceLocator.registerLazySingleton(() => FeeBloc());
  serviceLocator.registerLazySingleton(() => ProfileBloc());
  serviceLocator.registerLazySingleton(() => NoticeBloc());
  serviceLocator.registerLazySingleton(() => CalendarBloc());
  serviceLocator.registerLazySingleton(() => TimelineBloc());
}
