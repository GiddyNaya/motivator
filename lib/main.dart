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
import 'utils/styles_util.dart';

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
        apiKey: "AIzaSyB2q6UN6_wTKZudlyvHUsyHoko1CGY5Qaw",
        authDomain: "rockgarden-app.firebaseapp.com",
        projectId: "rockgarden-app",
        storageBucket: "rockgarden-app.appspot.com",
        messagingSenderId: "503524621123",
        appId: "1:503524621123:web:713b17d4c2f059c4978df6",
        measurementId: "G-HD7V9J8NTN"),
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
      // navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      initialRoute: Routes.landing,
      getPages: Routes.pages.values.toList(),
      // onGenerateRoute: Routes.generateRoute,
      transitionDuration: Duration(seconds: 0),
      unknownRoute: Routes.notFoundPage(),
    );
  }
}
