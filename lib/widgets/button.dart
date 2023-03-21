import '../utils/constants_util.dart';
import 'package:motivator/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SDButton extends StatefulWidget {
  String textContent;
  VoidCallback onPressed;
  var bgColor = primaryColor;
  var textColor = Colors.white;
  final double height;
  final double width;

  SDButton(this.textContent,
      {required this.onPressed,
      this.bgColor = primaryColor,
      this.textColor = Colors.white,
      this.width = double.infinity,
      this.height = 45.0});

  @override
  SDButtonState createState() => SDButtonState();
}

class SDButtonState extends State<SDButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        child: MaterialButton(
          height: widget.height,
          onPressed: widget.onPressed,
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: text(widget.textContent.toUpperCase(),
              isCentered: true, fontSize: 16, textColor: widget.textColor),
          color: widget.bgColor,
          shape: RoundedRectangleBorder(borderRadius: radius(6)),
        ));
  }
}
