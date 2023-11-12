import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/auth/bloc/auth_bloc.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';

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
            leadingWidget: const Icon(Icons.home),
            title: "Hello",
            titleWidget: const Text("MM"),
            centerTitle: true,
            endingWidgets: [
              const Text("data"),
              IconButton(onPressed: () {}, icon: const Icon(Icons.abc))
            ],
          ),
          body: Center(
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
                    BlocProvider.of<NavigationBloc>(context)
                        .add(const TabChanged(tabIndex: 1));
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
            ],
          )),
        );
      },
    );
  }
}
