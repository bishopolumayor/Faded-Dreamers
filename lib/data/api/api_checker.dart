import 'package:faded_dreamers/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiChecker{
  static void checkApi(Response response){
    if (response.statusCode==401){
      // Get.offNamed(AppRoutes.getSignInScreen());
    } else {

    }
  }
}