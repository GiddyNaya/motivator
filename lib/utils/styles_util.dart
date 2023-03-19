import 'package:motivator/main.dart';
import 'package:motivator/utils/constants_util.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// import 'package:intl/intl.dart';

BoxDecoration boxDecorations(
    {double radius = 8,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow
          ? [
              BoxShadow(
                  color: shadowColorGlobal, blurRadius: 10, spreadRadius: 2)
            ]
          : [const BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

BoxDecoration boxDecoration(
    {double radius = 80.0,
    Color backGroundColor = primaryColor,
    double blurRadius = 8.0,
    double spreadRadius = 8.0,
    Color radiusColor = Colors.black12,
    Gradient? gradient}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: radiusColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
      color: backGroundColor,
      gradient: gradient);
}

class CustomTheme extends StatelessWidget {
  Widget child;

  CustomTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: child,
    );
  }
}

TableBorder tableBorder() {
  return TableBorder(
      top: BorderSide(color: Colors.black),
      bottom: BorderSide(color: Colors.grey[300]!),
      left: BorderSide(color: Colors.grey[300]!),
      right: BorderSide(color: Colors.grey[300]!),
      verticalInside: BorderSide(color: Colors.grey[300]!),
      horizontalInside: BorderSide(color: Colors.grey, width: 1));
}

Color getTextColor() {
  return localStorage.isDarkModeOn ? Colors.white : Colors.black;
}

TextTheme textTheme(Color color) {
  return TextTheme(
    bodyText1: TextStyle(color: color),
    bodyText2: TextStyle(color: color),
  );
}

Widget preloader({required double width, required double height}) {
  return Container(
    height: height,
    width: width,
    color: const Color.fromARGB(150, 0, 0, 0),
    child: const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
}
