import 'dart:async';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/screens/home/pages/cart_page.dart';
import 'package:faded_dreamers/screens/home/pages/home_page.dart';
import 'package:faded_dreamers/screens/home/pages/orders_page.dart';
import 'package:faded_dreamers/screens/home/pages/profile_page.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/big_products_container.dart';
import 'package:faded_dreamers/widgets/otp_fields.dart';
import 'package:faded_dreamers/widgets/side_bar.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Column(
              children: [
                // space
                Spacing(
                  height: Dimensions.height70,
                ),
                // back, favorites
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.back();
                      },
                      child: Container(
                        width: Dimensions.width30,
                        height: Dimensions.height22,
                        decoration: const BoxDecoration(
                         /* image: DecorationImage(
                            image: AssetImage(
                              'assets/images/back2.png',
                            ),
                          ),*/
                        ),
                        child: Icon(Icons.arrow_back, color: AppColors.whiteColor, size: Dimensions.iconSize24,),
                      ),
                    ),
                    // favorites
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.font18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // empty
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      child: SizedBox(
                        width: Dimensions.width30,
                        height: Dimensions.height22,
                      ),
                    ),
                  ],
                ),
                // space
                Spacing(
                  height: Dimensions.height50,
                ),
                // products
                Obx(() {
                  List<ProductModel> products = productsController.favoriteProducts;
                  if(products.isNotEmpty) {
                    return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height40,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ProductModel product = products[index];
                        return BigProductsContainer(
                          product: product,
                        );
                      },
                      itemCount: products.length,
                    ),
                  );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // icon
                            Icon(
                              Icons.info_outline_rounded,
                              size: Dimensions.iconSize24 * 2,
                              color: AppColors.whiteColor,
                            ),
                            // space
                            Spacing(
                              height: Dimensions.height20,
                            ),
                            // text
                            Text(
                              'No favorites yet',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: Dimensions.font18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // space
                            Spacing(
                              height: Dimensions.height150,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
