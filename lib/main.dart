import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/helpers/dependencies.dart' as dep;
import 'package:faded_dreamers/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<UserController>(builder: (_) {
        return GetBuilder<ProductsController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Faded Dreamers',
            getPages: AppRoutes.routes,
            initialRoute: AppRoutes.getSplashScreen(),
          );
        });
      });
    });
  }
}
