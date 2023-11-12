import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/features/assignment/presentation/screen/assigmentPage.dart';
import 'package:schoolmanagement/features/fee/presentation/screens/feePage.dart';
import 'package:schoolmanagement/features/home/presentation/screens/homePage.dart';

import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/profile/presentation/profile.dart';

const bottomNavScreen = <Widget>[
  // homePage(),
  // assignmentPage(),
  // feePage(),
  // Profile(),
  Text("Home"),
  Text("Assignment"),
  Text("Fee"),
  Text("Profile"),
];

final List<Widget> pages = [
  homePage(),
  assignmentPage(),
  feePage(),
  Profile(),
];

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          // body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          body: pages.elementAt(state.tabIndex),
          bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assignment), label: "Assignment"),
                BottomNavigationBarItem(icon: Icon(Icons.money), label: "Fee"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
              currentIndex: state.tabIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.deepPurple,
              onTap: (index) {
                BlocProvider.of<NavigationBloc>(context)
                    .add(TabChanged(tabIndex: index));
              }),
        );
      },
    );
  }
}
