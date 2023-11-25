import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';

import '../../../../core/hiveLocalDB/loggedInState/loggedIn.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: CustomAppBar(
            parentContext: context,
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("HomePage"),
                Text(json.decode(loggedInHive().getLoginInfo()).toString()),
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    child: const Text("Logout")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/view_assignments");
                    },
                    child: const Text("Assignment")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/add_assignment");
                    },
                    child: const Text("Add Assignment")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/fee");
                    },
                    child: const Text("Fee")),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/profile");
                      },
                      child: const Text("Profile"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/notices");
                        },
                        child: const Text("Notice")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/calendar");
                        },
                        child: const Text("calender"))
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
