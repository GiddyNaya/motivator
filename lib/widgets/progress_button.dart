import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  final Function? onPressed;
  final double minWidth;
  final double maxWidth;
  final double radius;
  final double height;
  final bool isLoading;
  final EdgeInsets padding;
  final Duration animationDuration;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? progressColor;
  final TextStyle? textStyle;

  ProgressButton(this.text,
      {Key? key,
      this.textStyle,
      this.textColor = Colors.white,
      this.backgroundColor = Colors.blue,
      this.progressColor = Colors.white,
      this.onPressed,
      this.minWidth = 50.0,
      this.maxWidth = 400.0,
      this.radius = 25.0,
      this.height = 50.0,
      this.padding = EdgeInsets.zero,
      this.isLoading = false,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressButtonState();
  }
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation<Color?>? colorAnimation;
  double? width;
  Widget? progressIndicator;

  void startAnimations(bool isLoading) {
    Color? begin = widget.backgroundColor;
    Color? end = widget.backgroundColor;
    if (widget.isLoading) {
      width = widget.minWidth;
    } else {
      width = widget.maxWidth;
    }
    colorAnimation = ColorTween(begin: begin, end: end).animate(CurvedAnimation(
      parent: colorAnimationController!,
      curve: Interval(
        0,
        1,
        curve: Curves.easeIn,
      ),
    ));
    colorAnimationController!.forward();
  }

  Color? get backgroundColor => colorAnimation == null
      ? widget.backgroundColor
      : colorAnimation!.value ?? widget.backgroundColor;

  @override
  void initState() {
    super.initState();

    width = widget.maxWidth;

    colorAnimationController =
        AnimationController(duration: widget.animationDuration, vsync: this);
    colorAnimationController!.addStatusListener((status) {
      // if (widget.onAnimationEnd != null) {
      //   widget.onAnimationEnd!(status, widget.state);
      // }
    });

    // progressIndicator = widget.progressIndicator ??
    //     const CircularProgressIndicator(
    //       color: Colors.white,
    //     );
    // CircularProgressIndicator(
    //         // backgroundColor: widget.stateColors[widget.state!],
    //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
    // .center()
    // .paddingAll(10);
  }

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoading != widget.isLoading) {
      colorAnimationController?.reset();
      startAnimations(widget.isLoading);
    }
  }

  Widget getButtonChild(bool visibility) {
    if (widget.isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            color: widget.progressColor,
          )
        ],
      );
    }
    return AnimatedOpacity(
        opacity: visibility ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        child: Text(
          widget.text,
          style: widget.textStyle ??
              TextStyle(color: widget.textColor, fontWeight: FontWeight.w500),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController!,
      builder: (context, child) {
        return AnimatedContainer(
            width: width,
            height: widget.height,
            duration: widget.animationDuration,
            child: MaterialButton(
              padding: widget.padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(color: Colors.transparent, width: 0)),
              color: backgroundColor,
              onPressed: widget.onPressed as void Function()?,
              child: getButtonChild(
                  colorAnimation == null ? true : colorAnimation!.isCompleted),
            ));
      },
    );
  }
}
