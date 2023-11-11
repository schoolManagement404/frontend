import 'package:flutter/cupertino.dart';

SuffixIconButton({IconData? icon, Function? onTap}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Icon(
      icon,
    ),
  );
}

SuffixIconButton1({required Widget icon, Function? onTap}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: icon,
  );
}
