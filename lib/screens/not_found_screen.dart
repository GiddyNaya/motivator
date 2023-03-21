import '../../utils/constants_util.dart';
import 'package:motivator/utils/routes.dart';
import 'package:motivator/utils/widget_utils.dart';
import 'package:motivator/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            text("404", fontSize: 100, isBold: true, textColor: primaryColor),
            30.height,
            text("Page Not Found",
                fontSize: 50, isBold: true, textColor: Colors.black),
            40.height,
            text(
              "We couldn't find the page you're looking for.",
              fontSize: 30,
              maxLine: 5,
            ),
            30.height,
            SDButton("Return Home",
                width: 150,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.landing, (Route<dynamic> route) => false))
          ],
        ),
      ),
    );
  }
}
