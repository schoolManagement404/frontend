import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';

import '../../../core/hiveLocalDB/loggedInState/loggedIn.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(viewProfileEvent());
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context, text: state.message ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is profileErrorState) {
          return Scaffold(
            body: Center(child: Text("Error ${state.message!}")),
          );
        } else if (state is profileLoadedState) {
          final jsonData = state.profileList;
          final userData = jsonData["data"]["student"];

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("User profile"),
                  Text("Name: ${userData["name"]}"),
                  Text("Roll no: ${userData["roll_no"]}"),
                  Text("Class: ${userData["class"]}"),
                  Text("Section: ${userData["section"]}")
                ],
              ),
            ),
          );
        } else {
          return Scaffold(body: Text("sorry"));
        }
      },
    );
  }
}
