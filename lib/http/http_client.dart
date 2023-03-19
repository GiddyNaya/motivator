import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:motivator/utils/helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:motivator/models/api_response_model.dart';
import 'package:motivator/utils/constants_util.dart' as app_constants;

import '../main.dart';
import '../utils/routes.dart';

class HttpClient {
  final BuildContext context;
  HttpClient(this.context);

  Future<ApiResponseModel> doPost(String endpoint,
      {required Map<String, dynamic> body,
      bool isAuth = false,
      String? accessToken}) async {
    Response? response;
    try {
      if (isAuth && accessToken != null) {
        response = await http.post(
          Uri(scheme: "https", host: app_constants.ApiBaseUrl, path: endpoint),
          body: jsonEncode(body),
          headers: {
            'Authorization': "Bearer $accessToken",
            "content-type": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
        ).timeout(const Duration(seconds: app_constants.ConnectionTimeout));
      } else {
        response = await http.post(
          Uri(scheme: "https", host: app_constants.ApiBaseUrl, path: endpoint),
          body: jsonEncode(body),
          headers: {
            "content-type": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
        ).timeout(const Duration(seconds: app_constants.ConnectionTimeout));
      }
    } on TimeoutException catch (_) {
      return ApiResponseModel(
          success: false, message: app_constants.ErrorInConnection);
    } on SocketException catch (_) {
      return ApiResponseModel(
          success: false, message: app_constants.NoInternetConnection);
    } on Exception catch (_) {
      print(_);
      return ApiResponseModel(
          success: false, message: app_constants.ErrorInConnection);
    }

    return processResponse(response, body: body);
  }

  Future<ApiResponseModel> doGet(String endpoint,
      {String query = "", bool isAuth = false, String? accessToken}) async {
    Response? response;
    if (isAuth && accessToken != null) {
      await logout();
      return ApiResponseModel();
    }

    try {
      if (isAuth) {
        response = await http.get(
          Uri(
              scheme: "https",
              host: app_constants.ApiBaseUrl,
              path: endpoint,
              query: query),
          headers: {
            'Authorization': "Bearer $accessToken",
            "Access-Control-Allow-Origin": "*"
          },
        ).timeout(const Duration(seconds: app_constants.ConnectionTimeout));
      } else {
        response = await http.get(
          Uri(
              scheme: "https",
              host: app_constants.ApiBaseUrl,
              path: endpoint,
              query: query),
          headers: {"Access-Control-Allow-Origin": "*"},
        ).timeout(const Duration(seconds: app_constants.ConnectionTimeout));
      }
    } on TimeoutException catch (_) {
      return ApiResponseModel(
          success: false, message: app_constants.ErrorInConnection);
    } on SocketException catch (_) {
      return ApiResponseModel(
          success: false, message: app_constants.NoInternetConnection);
    } on Exception catch (_) {
      print(_);
      return ApiResponseModel(
          success: false, message: app_constants.ErrorInConnection);
    }

    return processResponse(response);
  }

  Future<ApiResponseModel> processResponse(Response response,
      {Map<String, dynamic>? body}) async {
    print('API Request Body $body');
    print('API Request URL ${response.request?.url}');
    print('API Request METHOD ${response.request?.method}');
    print('API Request StatusCode ${response.statusCode}');
    print('API Request Response Body ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return ApiResponseModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      return ApiResponseModel(
          success: false, message: app_constants.ErrorInConnectionServer);
    } else {
      String? message;
      try {
        var data = ApiResponseModel.fromJson(jsonDecode(response.body));
        message = data.message;
        if (response.statusCode == 401 ||
            (data.message != null &&
                    data.message.toString().contains("Session Expired") ||
                data.message
                    .toString()
                    .contains("Authorization Token not found"))) {
          try {
            SmartDialog.dismiss();
          } catch (_) {}
          toastDark(message);
          await logout();
        }
      } catch (_) {
        //...
      }
      return ApiResponseModel(
          success: false, message: message ?? app_constants.ErrorInConnection);
    }
  }

  Future<void> logout() async {
    await localStorage.clearAll();
    await Navigator.pushNamedAndRemoveUntil(
        getx.Get.context!, Routes.landing, (Route<dynamic> route) => false);
  }
}
