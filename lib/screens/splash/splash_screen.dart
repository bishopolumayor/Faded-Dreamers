import 'dart:async';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  bool _isLoading = false;

  String _loadingText = '';

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    Timer(
      const Duration(seconds: 2),
      () => _initializeApp(),
    );
  }

  void _initializeApp() async {
    bool status = await authController.getStatus();
    if (status) {
      bool userExists = await userController.checkUserExists();

      if (userExists) {
        setState(() {
          _isLoading = true;
          _loadingText = 'getting user...';
        });
        await userController.loadUser();
        setState(() {
          _isLoading = true;
          _loadingText = 'getting products...';
        });
        await productsController.getProducts();
        setState(() {
          _isLoading = true;
          _loadingText = 'initializing app...';
        });
        await productsController.getCart();
        setState(() {
          _isLoading = false;
          _loadingText = 'All done!';
        });
        Get.offAllNamed(AppRoutes.getHomeScreen());
      } else {
        setState(() {
          _isLoading = true;
          _loadingText = 'getting products...';
        });
        await productsController.getProducts();
        setState(() {
          _isLoading = true;
          _loadingText = 'initializing app...';
        });
        await productsController.getCart();
        setState(() {
          _isLoading = false;
          _loadingText = 'All done!';
        });
        Get.offAllNamed(AppRoutes.getSignInScreen());
      }
    } else {
      Get.snackbar(
        'Error',
        'Backend error',
        colorText: AppColors.whiteColor,
        backgroundColor: AppColors.redColor,
      );
      Get.offAllNamed(AppRoutes.getErrorScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg1.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height240 + Dimensions.height15,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo1.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              if (_isLoading)
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width70,
                      ),
                      child: const LinearProgressIndicator(
                        color: AppColors.whiteColor,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                    const Spacing(),
                    Text(
                      _loadingText,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font12,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
