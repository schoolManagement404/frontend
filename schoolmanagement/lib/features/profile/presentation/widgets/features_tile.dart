import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String leadingImage;
  final String route;

  const FeatureTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.leadingImage,
      required this.route});

  void pageNavigation(BuildContext context) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 2),
              blurRadius: 4,
            )
          ],
        ),
        child: SizedBox(
          height: 65,
          child: ListTile(
            onTap: () => {pageNavigation(context)},
            leading: Image.asset(leadingImage),
            title: Text(
              title,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13.1),
              ),
            ),
            subtitle: Text(subTitle,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 11),
                )),
            trailing: InkWell(
                onTap: () => {pageNavigation(context)},
                child: const Icon(
                  Icons.arrow_right_sharp,
                  size: 35,
                )),
          ),
        ),
      ),
    );
  }
}
