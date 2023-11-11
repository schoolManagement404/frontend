import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';

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
          appBar: CustomAppBar(
            appBarHeight: 50,
            backGroundColor: Colors.amber,
            leadingWidget: Icon(Icons.home),
            title: "Hello",
            titleWidget: Text("MM"),
            centerTitle: true,
            endingWidgets: [
              Text("data"),
              IconButton(onPressed: () {}, icon: Icon(Icons.abc))
            ],
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("HomePage"),
              Text(json.decode(loggedInHive().getLoginInfo()).toString()),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: Text("Logout")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/view_assignments");
                  },
                  child: Text("Assignment")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/add_assignment");
                  },
                  child: Text("Add Assignment")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/fee");
                  },
                  child: Text("Fee")),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: Text("Profile"),
              )
            ],
          )),
        );
      },
    );
  }
}
