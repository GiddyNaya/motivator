import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:motivator/main.dart';

import 'package:motivator/responsive.dart' as resp;
import 'package:motivator/utils/helper_utils.dart';
import 'package:motivator/utils/widget_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import 'components/share_widget.dart';

class MainScreen extends StatelessWidget {
  var isLiked = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool mobile = resp.Responsive.isMobile(context);
    return SafeArea(
      child: LayoutBuilder(builder: (_, constraints) {
        return Obx(
          () => Scaffold(
            backgroundColor: transparentColor,
            body: Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/beams-home-dark'.jpg",
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                  ).visible(backgroundColor.value != Colors.white),
                  Image.asset(
                    "assets/images/beams-home.jpg",
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.cover,
                  ).visible(backgroundColor.value == Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _actionButton(Icons.fullscreen, size: 50,
                              onPressed: () async {
                        requestFullscreen();
                      })
                          .paddingBottom(5)
                          .visible(constraints.device == DeviceSize.desktop),
                      (mobile ? 20 : 30).width,
                      _actionButton(CupertinoIcons.moon_stars,
                          size: (mobile ? 30 : 40), onPressed: () async {
                        await toggleBackgroundColor();
                      }),
                      (mobile ? 20 : 30).width,
                      _actionButton(
                        CupertinoIcons.square_grid_2x2,
                        size: (mobile ? 30 : 40),
                        onPressed: () {},
                      ),
                    ],
                  ).paddingAll(20).visible(!hasFullscreen()),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                                "Success is not final, failure is not fatal: It is the courage to continue that counts.",
                                fontSize: mobile ? 22 : 30,
                                maxLine: 10,
                                isCentered: true,
                                isBold: true),
                            (mobile ? 10 : 20).height,
                            text("-Winston Churchill"),
                            (mobile ? 50 : 30).height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ShareWidget(
                                    child: Icon(
                                      CupertinoIcons.share,
                                      size: (mobile ? 28 : 44),
                                    ),
                                    data:
                                        "Success is not final, failure is not fatal: It is the courage to continue that counts.\n\n-Winston Churchill"),
                                (mobile ? 20 : 30).width,
                                _actionButton(
                                    isLiked.value
                                        ? CupertinoIcons.heart_fill
                                        : CupertinoIcons.heart,
                                    size: (mobile ? 30 : 50), onPressed: () {
                                  isLiked.value = !isLiked.value;
                                }),
                              ],
                            )
                          ],
                        ),
                      ).paddingAll(20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _actionButton(IconData icon,
      {required double size,
      required void Function()? onPressed,
      Color? color}) {
    return IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        icon: Icon(
          icon,
          color: color,
          size: size,
        ));
  }
}
