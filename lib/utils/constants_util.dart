import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3c65ff);
const secondaryColor = Color(0xFFffffff);
const bgColorDark = Color(0x3a3d4f);
const sideSubMenuColor = Color(0xFFeeeeff);
const primarAccentColor = Color(0xFF1f74df);
const sdSecondaryColorPink = Color(0xFFbf049f);
const primaryColorLight = Color(0xFFa5ccff);
const toastDarkBgColor = Color(0xFF1D1D1D);
const toastDarkTextColor = Color(0xFFFFFFFF);
const trueRed = Color.fromARGB(255, 215, 0, 0);

const defaultPadding = 16.0;
const appVersion = 1.00071;

/*"font sizes*/
const TextSizeSmall = 12.0;
const TextSizeSMedium = 14.0;
const TextSizeMedium = 16.0;
const TextSizeLargeMedium = 18.0;
const TextSizeNormal = 20.0;
const TextSizeLarge = 24.0;
const TextSizeXLarge = 30.0;
const TextSizeXXLarge = 35.0;

// Preference keys
const PrefFirstLaunch = 'PrefFirstLaunch';
const PrefDarkMode = 'PrefDarkMode';

class PageTitle {
  static const appName = "Motivator";
}

// const FileStorageBaseUrl = 'https://rockgarden-api.herokuapp.com';
const ApiBaseUrl = 'api.rockgardenehr.com';
const ApiPort = 8080;

const ErrorInConnection = 'Error in connection';
const NoInternetConnection = 'No internet connection';
const ErrorInConnectionServer = 'Internal Server Error!';
const PleaseWaitForLoading = "Please wait for loading to complete.";
const ConnectionTimeout = 300; //seconds

class ApiEndpoints {
  static const getQuotes = "/api/get-quotes";
}

class QuoteCategory {
  static const love = "Love";
  static const family = "Family";
  static const work = "Work";
}

class ShareOption {
  static const copy = "Copy";
  static const facebook = "Facebook";
  static const instagram = "Instagram";
  static const twitter = "Twitter";
}
