import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectingTiles extends StatelessWidget {
  final String text;
  final Icon icon;
  final dynamic onPressed;
  const SelectingTiles(
      {super.key, required this.text, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onPressed,
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          splashColor: Color.fromARGB(255, 239, 250, 253),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      Text(
                        text,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 29, 12, 105),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
