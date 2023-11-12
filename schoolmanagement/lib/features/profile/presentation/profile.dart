
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/features/home/presentation/widget/widget.dart';
import 'package:schoolmanagement/features/navigationShell/bloc/navigation/navigation_bloc.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';
import 'package:schoolmanagement/features/profile/presentation/widgets/curved_nav/draw_curvednav.dart';
import 'package:schoolmanagement/features/profile/presentation/widgets/image.dart';
import 'package:schoolmanagement/features/profile/presentation/widgets/tiles.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double width_of_image = 100;
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
          userData["profile_pic"] =
              'https://iidamidamerica.org/wp-content/uploads/2020/12/male-placeholder-image.jpeg';

          return Scaffold(
              appBar: CustomAppBar(
                appBarHeight: 56.0,
                leadingWidget: IconButton(
                  onPressed: () {
                    //change the index to 0
                    BlocProvider.of<NavigationBloc>(context)
                        .add(const TabChanged(tabIndex: 0));
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                titleWidget: const Text(
                  'User Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backGroundColor: Colors.deepPurple,
              ),
              body: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper:
                          CustomShape(), // this is my own class which extendsCustomClipper
                      child: Container(
                        height: 100,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: MediaQuery.of(context).size.width * 0.5 -
                        width_of_image / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ImageNetwork(
                        url: userData["profile_pic"] ??
                            "https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                        width: 100,
                        height: 100,
                        loadingWidget: const Material(
                          shape: CircleBorder(),
                          child: Icon(Icons.person, size: 50),
                        ),
                        errorWidget: const Material(
                          shape: CircleBorder(),
                          child: Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Welcome ,",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  " ${userData["name"] ?? "User"}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Class :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " ${userData["class"] ?? "Class"} ${userData["section"] ?? "Section"}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    top: 250,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectingTiles(
                                    text: "Notices",
                                    icon: const Icon(
                                      Icons.person_2_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(const TabChanged(tabIndex: 4));
                                    },
                                  ),
                                  SelectingTiles(
                                    text: "App Settings",
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      print("Settings");
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectingTiles(
                                    text: "Class",
                                    icon: const Icon(
                                      Icons.class_,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      print("Class");
                                    },
                                  ),
                                  SelectingTiles(
                                    text: "Fees",
                                    icon: const Icon(
                                      Icons.money_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(const TabChanged(tabIndex: 2));
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectingTiles(
                                    text: "Assignments",
                                    icon: const Icon(
                                      Icons.notes_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(const TabChanged(tabIndex: 1));
                                    },
                                  ),
                                  SelectingTiles(
                                    text: "Personal Records",
                                    icon: const Icon(
                                      Icons.info_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      print("More info");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return const Scaffold(
              body: Center(child: Text("Unable to Load Profile Page")));
        }
      },
    );
  }
}
