import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assigmentPage.dart';
import 'package:schoolmanagement/features/fee/presentation/screens/feePage.dart';
import 'package:schoolmanagement/features/home/presentation/screens/homePage.dart';

import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/navigationShell/navbar.dart';
import 'package:schoolmanagement/features/notices/presentation/noticesPage.dart';
import 'package:schoolmanagement/features/profile/presentation/profile.dart';

final List<Widget> pages = [
  const homePage(),
  const assignmentPage(),
  const feePage(),
  const Profile(),
  const noticePage(),
];

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: pages.elementAt(state.tabIndex),
          bottomNavigationBar: CustomNavBar(
              index: state.tabIndex,
              onTap: (index) {
                BlocProvider.of<NavigationBloc>(context)
                    .add(TabChanged(tabIndex: index));
              }),
        );
      },
    );
  }
}