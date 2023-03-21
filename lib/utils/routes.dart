import '../screens/main_screen.dart';
import '../screens/not_found_screen.dart';
import 'package:get/get.dart';

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
}
