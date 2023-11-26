import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolmanagement/core/Error/loadingScreen/loadingScreen.dart';
import 'package:schoolmanagement/core/constants/colors/constants.dart';
import 'package:schoolmanagement/features/home/presentation/widget/Appbar.dart';
import 'package:schoolmanagement/features/profile/bloc/profile_bloc.dart';
import 'package:schoolmanagement/features/profile/presentation/widgets/features_tile.dart';
import 'package:schoolmanagement/features/profile/presentation/widgets/profileCard.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
            backgroundColor: backgroundColor,
            body: Center(child: Text("Error ${state.message!}")),
          );
        } else if (state is profileLoadedState) {
          final jsonData = state.profileList;
          final userData = jsonData["data"]["student"];

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: CustomAppBar(parentContext: context),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileCard(
                    userData: userData,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "More Features",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FeatureTile(
                            title: 'View Fee Details',
                            subTitle: 'View your fee details',
                            leadingImage: 'assets/images/fee.png',
                            route: '/fee',
                          ),
                          FeatureTile(
                            title: "Gallery",
                            subTitle: 'View Photos and Videos',
                            leadingImage: 'assets/images/gallery.png',
                            route: '/gallery',
                          ),
                          FeatureTile(
                            title: 'Attendance Record',
                            subTitle: 'View your attendance',
                            leadingImage: 'assets/images/attendance.png',
                            route: '/calendar',
                          ),
                          FeatureTile(
                            title: "Events",
                            subTitle: 'Upcoming Events and Programs',
                            leadingImage: 'assets/images/event.png',
                            route: '/events',
                          ),
                          FeatureTile(
                            title: 'Report Card',
                            subTitle: 'View Exams Result',
                            leadingImage: 'assets/images/reportCard.png',
                            route: '/report',
                          ),
                          FeatureTile(
                            title: "Routine",
                            subTitle: 'View your Exam and Class Routine',
                            leadingImage: 'assets/images/routine.png',
                            route: '/timeline',
                          ),
                          Gap(100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
              body: Center(child: Text("Unable to Load Profile Page")));
        }
      },
    );
  }
}
