import 'package:motivator/main.dart';
import '../screens/main_screen.dart';
import '../screens/not_found_screen.dart';
import 'package:motivator/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class Routes {
  static const landing = '/';
  static const notFound = '/not-found';

  static GetPage<dynamic> notFoundPage() => GetPage(
      name: Routes.notFound,
      page: () => NotFoundScreen(),
      title: "Page Not Found");

  static final Map<String, GetPage> pages = {
    landing: GetPage(
      name: landing,
      page: () => MainScreen(),
    ),
  };

  // static Route<dynamic>? generateRoute(RouteSettings settings) {
  //   Map<String, GetPage> accessiblePages = {};
  //   var restrictedRoutes = localStorage.getRestrictedRoutes();
  //   if (settings.name.isEmptyOrNull) return null;
  //   var path = settings.name ?? "";
  //   var rootPath = path;
  //   if (rootPath.startsWith("/")) rootPath = rootPath.replaceFirst("/", "");
  //   rootPath = rootPath.split("/")[0];
  //   if (localStorage.loggedInUser == null &&
  //       settings.name?.contains(logout) != true &&
  //       settings.name != landing) {
  //     return NoAnimationMaterialPageRoute(
  //         settings: settings, builder: (_) => pages[logout]!.page());
  //   } else {
  //     for (var entry in pages.entries) {
  //       if (!restrictedRoutes.contains(rootPath)) {
  //         accessiblePages[entry.key] = entry.value;
  //       }
  //     }
  //   }
  //   // print("path: $path");
  //   // print("accessiblePages: $accessiblePages");
  //   if (accessiblePages[path] != null) {
  //     // print("Seen page: ${accessiblePages[settings.name]}");
  //     return NoAnimationMaterialPageRoute(
  //         settings: settings, builder: (_) => accessiblePages[path]!.page());
  //   }
  //   // print("Unseen page: ${settings.name}");
  //   return PageRedirect(
  //     settings: settings,
  //     unknownRoute: notFoundPage(),
  //   ).page();
  // }

}
