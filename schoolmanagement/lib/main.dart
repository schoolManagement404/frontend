import 'package:flutter/material.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/auth/authService/mongodbAuthProvider.dart';
import 'package:schoolmanagement/config/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/assignment/bloc/assignment_bloc.dart';
import 'package:schoolmanagement/features/fee/bloc/fee_bloc.dart';
import 'package:schoolmanagement/features/login/presentation/screen/loginPage.dart';
import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/navigationShell/scaffold_with_navbar.dart';
import 'package:schoolmanagement/features/notices/bloc/notice_bloc/notice_bloc.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';

import 'features/calendar/presentation/screens/calenderPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        initialRoute: "/",
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(mongoDBAuth()),
            ),
            BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
            BlocProvider<AssignmentBloc>(
              create: (context) => AssignmentBloc(),
            ),
            BlocProvider<FeeBloc>(create: (context) => FeeBloc()),
            BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
            BlocProvider<NoticeBloc>(
              create: (context) => NoticeBloc(),
            ),
          ],
          child: const CalenderPage(),
        ));
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const ScaffoldWithNavBar();
        } else if (state is AuthStateLoggedOut) {
          return const loginPage();
        } else {
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
