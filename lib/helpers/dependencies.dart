import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/data/api/api_client.dart';
import 'package:faded_dreamers/data/repo/auth_repo.dart';
import 'package:faded_dreamers/data/repo/products_repo.dart';
import 'package:faded_dreamers/data/repo/user_repo.dart';
import 'package:faded_dreamers/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api clients
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repos
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
          () => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => ProductsRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => ProductsController(productsRepo: Get.find()));
}
