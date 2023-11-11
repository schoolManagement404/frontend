import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.leadingWidget,
    this.titleWidget,
    this.postWidget,
    this.backGroundColor,
    this.centerTitle,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftRadius,
    this.bottomRightRadus,
    required this.appBarHeight,
    this.endingWidgets,
  }) : super(key: key);

  final String title;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? postWidget;
  final Color? backGroundColor;
  final bool? centerTitle;
  final Radius? topLeftBorderRadius;
  final Radius? topRightBorderRadius;
  final Radius? bottomLeftRadius;
  final Radius? bottomRightRadus;
  final double appBarHeight;
  final List<Widget>? endingWidgets;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingWidget,
      title: titleWidget ?? Text(title),
      backgroundColor: backGroundColor,
      centerTitle: centerTitle,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: topLeftBorderRadius ?? Radius.zero,
        topRight: topRightBorderRadius ?? Radius.zero,
        bottomLeft: bottomLeftRadius ?? Radius.zero,
        bottomRight: bottomRightRadus ?? Radius.zero,
      )),
      actions: endingWidgets,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, appBarHeight);
}

class CustomSnackBar {
  final String message;
  final int timeInSeconds;
  const CustomSnackBar({required this.message, required this.timeInSeconds});

  static show({
    required BuildContext context,
    required message,
    required timeInSeconds,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      elevation: 0.0,
      duration: Duration(seconds: timeInSeconds),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      )),
    ));
  }
}
