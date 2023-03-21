import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../utils/constants_util.dart';

Widget text(String? text,
    {double? fontSize,
    Color? textColor,
    var isCentered = false,
    var isEnd = false,
    var isBold = false,
    var maxLine = 1,
    double? latterSpacing}) {
  return Text(
    text ?? "",
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
            ? TextAlign.start
            : TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: textColor,
        // height: 1.5,
        letterSpacing: latterSpacing),
  );
}

Widget headerText(String? title,
    {double? fontSize = 20,
    Color? textColor,
    var isCentered = false,
    var isBold = true,
    var maxLine = 1}) {
  return text(title,
      fontSize: fontSize,
      textColor: textColor,
      isCentered: isCentered,
      isBold: isBold,
      maxLine: maxLine);
}

Widget pillWidget(String text, {Color? bgColor, Color? textColor}) => Container(
      //width: 100.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.blueAccent,
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0, color: textColor ?? Colors.white),
        ),
      ),
    );

Widget preloader(
    {required double width,
    required double height,
    double? value,
    Color bgColor = const Color.fromARGB(150, 0, 0, 0)}) {
  return Container(
    height: height,
    width: width,
    color: bgColor,
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        value: value,
      ),
    ),
  );
}

Widget preloaderMain(
    {double? width,
    double? height,
    String? loadingText = "Loading... Please wait.",
    Color bgColor = const Color.fromARGB(150, 0, 0, 0)}) {
  return Container(
    height: height ?? double.infinity,
    width: width ?? double.infinity,
    color: bgColor,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
            color: Colors.white,
            secondRingColor: Colors.blue.shade300,
            thirdRingColor: Colors.pink.shade300,
            size: 100,
          ),
          15.height,
          text(loadingText, textColor: Colors.white, maxLine: 5)
              .paddingTop(10)
              .visible(loadingText != null)
        ],
      ),
    ),
  );
}

Widget textField({
  String? label,
  String? hint,
  int minLines = 1,
  int? maxLines,
  bool enabled = true,
  bool isDropDown = false,
  InputDecoration? decoration,
  TextInputType? keyboardType,
  TextEditingController? controller,
  void Function(String)? onChanged,
}) {
  return Container(
    // color: !isDropDown && !enabled ? Colors.grey.shade300 : null,
    child: TextField(
      cursorWidth: 1,
      // autocorrect: true,
      // autofocus: false,
      onChanged: onChanged,
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      // textCapitalization: TextCapitalization.words,
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            hintText: hint,
            // labelStyle: secondaryTextStyle(textColor: sdPrimaryColor),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
    ),
  );
}

class SmartButton extends StatelessWidget {
  String textContent;
  Widget? icon;
  VoidCallback onPressed;
  var bgColor = primaryColor;
  var textColor = Colors.black;
  final double height;
  final double? width;

  SmartButton(this.textContent,
      {Key? key,
      required this.onPressed,
      this.bgColor = primaryColor,
      this.icon,
      this.textColor = Colors.white,
      this.height = 45.0,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      onPressed: onPressed,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: icon,
          ).paddingRight(icon != null ? 5 : 0),
          text(textContent.toUpperCase(), textColor: textColor)
        ],
      ),
      color: bgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
    );
  }
}

Widget iSmartButton(String textContent,
    {required VoidCallback onPressed, double height = 45.0, double? width}) {
  return SmartButton(
    textContent,
    height: height,
    width: width,
    onPressed: onPressed,
    bgColor: sdSecondaryColorPink,
    textColor: Colors.white,
  );
}

Widget toolbar(String title,
    {bool showBackButton = true,
    Color? color,
    bool isDialog = false,
    double? width}) {
  return Container(
    color: color ?? primaryColor,
    height: 68,
    width: width,
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isDialog
                ? CloseButton(
                    color: Colors.white,
                    onPressed: () {
                      // Navigator.maybePop(Get.context!);
                      SmartDialog.dismiss();
                    },
                  )
                : BackButton(
                    color: Colors.white,
                  )
          ],
        ).paddingLeft(5).visible(showBackButton),
        text(title, textColor: Colors.white, fontSize: 20, maxLine: 1)
            .paddingSymmetric(horizontal: 35)
            .center(),
      ],
    ).paddingAll(10),
  );
}

Widget refreshButton({required Function()? onPressed, bool isMobile = false}) {
  return MaterialButton(
    height: 45,
    onPressed: onPressed,
    color: sdSecondaryColorPink,
    child: Row(children: [
      Icon(
        Icons.refresh,
        color: Colors.white,
      ),
      text("Refresh", textColor: Colors.white).visible(!isMobile)
    ]),
  );
}

class SDRightIconButton extends StatefulWidget {
  static String tag = '/T4Button';
  String textContent;
  VoidCallback onPressed;
  var height = 45.0;
  var fontSize = 16;
  var iconSize = 20.0;
  double? width;
  Color bgColor = Colors.white;
  Color iconBgColor = sdSecondaryColorPink;
  Color textColor = primaryColor;
  Color bgColorHolder = Colors.white;
  IconData? icon;

  SDRightIconButton({
    Key? key,
    required this.textContent,
    required this.onPressed,
    this.icon,
    this.fontSize = 16,
    this.iconSize = 20.0,
    this.width,
    this.height = 45.0,
    this.bgColor = Colors.white,
    this.iconBgColor = sdSecondaryColorPink,
    this.textColor = primaryColor,
  }) : super(key: key);

  @override
  SDRightIconButtonState createState() => SDRightIconButtonState();
}

class SDRightIconButtonState extends State<SDRightIconButton> {
  @override
  void initState() {
    widget.bgColorHolder = widget.bgColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: MaterialButton(
        height: widget.height,
        onPressed: widget.onPressed,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.textContent,
                textAlign: TextAlign.center,
                style: boldTextStyle(
                    size: widget.fontSize,
                    color: widget.textColor,
                    letterSpacing: 2),
              ),
            ),
            Container(
              width: widget.iconSize + 10,
              height: widget.iconSize + 10,
              decoration: BoxDecoration(
                  color: widget.iconBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: widget.iconSize,
              ).center(),
            ),
          ],
        ),
        color: widget.bgColorHolder,
        shape: RoundedRectangleBorder(borderRadius: radius(widget.height / 2)),
      ),
    );
  }
}

Widget ratingBar(
    {averageRating,
    int? totalReviews,
    bool hideTotalRatings = false,
    bool darkText = false}) {
  return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          RatingBar.builder(
            initialRating: averageRating?.toDouble() ?? 0.0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: true,
            itemCount: 5,
            itemSize: 25.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              //printWrapped(rating);
            },
          ),
          3.width,
          if (!hideTotalRatings)
            text(
                (averageRating != null && averageRating > 0.0)
                    ? "${averageRating.toStringAsFixed(1)} ${averageRating == 1 ? 'star' : 'star(s)'} | ${totalReviews?.toString() ?? ''} reviews"
                    : "No reviews yet",
                fontSize: 14,
                textColor: darkText ? Colors.black : Colors.white),
          if (hideTotalRatings)
            text(
                "${averageRating?.toStringAsFixed(1)} ${averageRating == 1 ? 'star' : 'star(s)'}",
                fontSize: 14,
                textColor: darkText ? Colors.black : Colors.white),
        ],
      ));
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
