import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int index;
  final dynamic onTap;
  const CustomNavBar({super.key, required this.index, this.onTap});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Material(
        shadowColor: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: DotNavigationBar(
            margin: const EdgeInsets.only(left: 20, right: 20),
            selectedItemColor: Colors.deepPurple,
            currentIndex: widget.index,
            dotIndicatorColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey[800],
            splashBorderRadius: 50,
            enableFloatingNavBar: false,
            backgroundColor: Colors.grey[50],
            borderRadius: 100,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            enablePaddingAnimation: true,
            onTap: widget.onTap,
            items: [
              /// Home
              DotNavigationBarItem(
                icon: Icon(Icons.home),
                // selectedColor: Color(0xff73544C),
              ),

              /// Likes
              DotNavigationBarItem(
                icon: Icon(Icons.assessment),
                // selectedColor: Color(0xff73544C),
              ),

              /// Search
              DotNavigationBarItem(
                icon: Icon(Icons.attach_money_sharp),
                // selectedColor: Color(0xff73544C),
              ),

              /// Profile
              DotNavigationBarItem(
                icon: Icon(Icons.person),
                // selectedColor: Color(0xff73544C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
