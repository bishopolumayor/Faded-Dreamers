import 'dart:convert';

import 'package:faded_dreamers/data/api/api_checker.dart';
import 'package:faded_dreamers/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
    String consumerKey = AppConstants.CONSUMER_KEY;
    String consumerSecret = AppConstants.CONSUMER_SECRET;
    final String credentials = '$consumerKey:$consumerSecret';
    final String encodedCredentials = base64.encode(utf8.encode(credentials));
    _mainHeaders = {
      'Authorization': 'Basic $encodedCredentials',
    };
  }

  /*void updateHeader(String token) {
    _mainHeaders = {
      'Authorization': 'Bearer $token',
    };
    if (kDebugMode) {
      print('update header called for $token');
    }
  }*/

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      if (kDebugMode) {
        print('$baseUrl $uri');
        print("getData response ${response.body}");
      }
      return response;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      if (kDebugMode) {
        print('$baseUrl $uri $body');
        print("postData response ${response.body}");
      }

      // if (response.statusCode == 401 &&
      //     response.hasError &&
      //     response.body['error'] == 'Unauthorized') {
      //   // final authController = Get.find<AuthController>();
      //   Get.snackbar(
      //       'Expired Session', 'Your session has expired, please login again');
      //   // authController.logout();
      // }
      // ApiChecker.checkApi(response);

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('from api post client');
        print(e.toString());
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {

      Response response = await put(uri, body, headers: headers ?? _mainHeaders);
      if (kDebugMode) {
        print("putting ${response.body}");
      }
      if (response.statusCode == 401 && response.hasError && response.body['error'] == 'Unauthorized') {
        // final authController = Get.find<AuthController>();
        // Get.snackbar('Expired Session', 'Your session has expired, please login again');
        // authController.logout();
      }
      ApiChecker.checkApi(response);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('from api put client');
        print(e.toString());
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri,  {Map<String, String>? headers}) async {
    try {
      Response response = await delete(uri,  headers: headers ?? _mainHeaders);
      return response;
    } catch(e){
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

}
