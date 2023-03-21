import 'package:firebase_core/firebase_core.dart';
import 'package:motivator/utils/helper_utils.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/constants_util.dart';
import 'package:motivator/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'http/http_client.dart';
import 'http/services/api_service.dart';
import 'mixins/local_storage.dart';

String currentRoute = Routes.landing;
LocalStorage localStorage = LocalStorage();
var _navigatorKey = GlobalKey<NavigatorState>();
late HttpClient httpClient;
late ApiService apiService;
var backgroundColor = Colors.white.obs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  await initialize();
  await localStorage.init();
  if (localStorage.isDarkModeOn) {
    backgroundColor = bgColorDark.obs;
  }
  runApp(MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSy********************Y5Qaw",
        authDomain: "my-app.firebaseapp.com",
        projectId: "my-app",
        storageBucket: "my-app.appspot.com",
        messagingSenderId: "1234567890",
        appId: "1:1234567890:web:71***********4978df6",
        measurementId: "G-HD7********"),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    httpClient = HttpClient(context);
    apiService = ApiService(httpClient);
    _navigatorKey = navigatorKey;
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: PageTitle.appName,
      themeMode: getThemeMode(),
      darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)),
      theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme)),
      builder: FlutterSmartDialog.init(),
      initialRoute: Routes.landing,
      getPages: Routes.pages.values.toList(),
      transitionDuration: Duration(seconds: 0),
      unknownRoute: Routes.notFoundPage(),
    );
  }
}
