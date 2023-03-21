import 'dart:html';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:motivator/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:motivator/responsive.dart' as resp;
import '../main.dart';
import '../utils/constants_util.dart';

final currencyFormat = NumberFormat('#,##0.00', 'en_US');
final beforeNonLeadingCapitalLetter = RegExp(r"(?=(?!^)[A-Z])");
final decimalFormatter = NumberFormat.decimalPattern();

Future<void> launchUrl(String? url) async {
  if (url != null) {
    if (await canLaunch(url)) await launch(url);
  }
}

void setPageTitle(String title, BuildContext context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: title,
    primaryColor: Theme.of(context).primaryColor.value, // This line is required
  ));
}

void clearOverlay(BuildContext context) {
  // The below block is a dirty hack that fixes an overlay bug that
  // occurs when a textfield is focused and SmartDialog.show is triggered:
  // In other to fix the overlay, we just show a menu and close immediately.
  showMenu(
    context: Get.context!,
    color: transparentColor,
    position: RelativeRect.fromLTRB(100, 100, 100, 100),
    items: [
      PopupMenuItem<String>(child: const SizedBox(), value: 'Nothing'),
    ],
  );
  finish(Get.context!);
}

Future<void> showSideMenu(BuildContext context,
    {required String title,
    required Widget child,
    bool useScrollView = true,
    required double height,
    required ScrollController controller,
    String? tag}) async {
  void showDialog() {
    SmartDialog.show(
      backDismiss: false,
      clickBgDismissTemp: false,
      isLoadingTemp: false,
      alignmentTemp: Alignment.centerRight,
      tag: tag,
      widget: Column(
        children: [
          toolbar(title, width: rightMenuWidth(context), isDialog: true),
          Container(
            width: rightMenuWidth(context),
            height: height,
            color: Colors.white,
            child: Scrollbar(
              isAlwaysShown: resp.Responsive.isDesktop(context),
              controller: controller,
              child: useScrollView
                  ? SingleChildScrollView(child: child, controller: controller)
                  : child,
            ),
          ).expand()
        ],
      ),
    );
  }

  try {
    showDialog();
  } catch (_) {
    clearOverlay(context);
    showDialog();
  }
}

double rightMenuWidth(context) {
  Size size = MediaQuery.of(context).size;
  var mobile = resp.Responsive.isMobile(context);
  return mobile ? size.width : 500;
}

void toastDark(String? text) {
  if (text.isEmptyOrNull) return; // text = "An unknown error occured.";
  Fluttertoast.showToast(
      msg: text.validate(),
      backgroundColor: toastDarkBgColor,
      textColor: toastDarkTextColor,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
      webBgColor: "#1D1D1D",
      webPosition: "center");
}

Future<void> hideLoading() async {
  try {
    finish(Get.context!);
  } catch (_) {
    print(_);
  }
}

Future<void> showLoading({String message = "Loading... Please wait."}) async {
  try {
    showGeneralDialog(
        // context: Get.context!,
        context: navigator!.context,
        pageBuilder: (a, e, d) {
          return preloaderMain(loadingText: message);
        });
  } catch (_) {
    print(_);
  }
  // await Smar
}

Future<void> copyToClipboard(String? text) async {
  await Clipboard.setData(new ClipboardData(text: text)).then((_) {
    toastDark('Text copied to your clipboard');
  });
}

int random(min, max) {
  return min + Random().nextInt(max + 1 - min);
}

Future<void> toggleBackgroundColor() async {
  await localStorage.setDarkMode(!localStorage.isDarkModeOn);
  Get.changeThemeMode(getThemeMode());
  if (localStorage.isDarkModeOn) {
    backgroundColor.value = bgColorDark;
  } else {
    backgroundColor.value = bgColorLight;
  }
}

ThemeMode getThemeMode() {
  return localStorage.isDarkModeOn ? ThemeMode.dark : ThemeMode.light;
}

void requestFullscreen() {
  if (kIsWeb) document.documentElement?.requestFullscreen();
}

void exitFullscreen() {
  if (kIsWeb) document.exitFullscreen();
}

bool hasFullscreen() {
  return kIsWeb && (document.fullscreenElement != null);
}
