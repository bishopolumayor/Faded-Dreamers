import 'dart:math';

import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/screens/home/components/popular_recommended_products.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/screens/home/components/home_banner.dart';
import 'package:faded_dreamers/widgets/big_products_container.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final VoidCallback openSidebar;

  const HomePage({
    super.key,
    required this.openSidebar,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductsController productsController = Get.find<ProductsController>();

  int _selectedPage = 2;

  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    initializeHomePage();
  }

  void initializeHomePage() async {
    products = productsController.allProducts;
  }

  void _switchPage(int page) {
    setState(() {
      _selectedPage = page;
      switch (page) {
        case 0:
          products = productsController.seedsList;
          break;
        case 1:
          products = productsController.indicaList;
          break;
        case 2:
          products = productsController.allProducts;
          break;
        case 3:
          products = productsController.sativaList;
          break;
        case 4:
          products = productsController.hybridList;
          break;
        default:
          products = productsController.allProducts;
          break;
      }
    });
  }

  void orderSpecialHybrid() async {
    List<ProductModel> hybridProducts = productsController.hybridList;

    if (hybridProducts.isNotEmpty) {
      final random = Random();
      int randomIndex = random.nextInt(hybridProducts.length);
      ProductModel randomProduct = hybridProducts[randomIndex];
      Get.toNamed(
        AppRoutes.getProductDetailScreen(),
        arguments: randomProduct,
      );
    } else {
      Get.snackbar('No hybrid', 'Come Back later', colorText: AppColors.whiteColor, backgroundColor: AppColors.mainColor,);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: AppColors.whiteColor,
        child: Stack(
          children: [
            Positioned(
              // top: 20,
              top: (Dimensions.height20 * 14) + Dimensions.height15,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height22 * 100,
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/bg3.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                // space
                Spacing(
                  height: Dimensions.height100,
                ),
                // menu logo search
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // menu
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.openSidebar();
                        },
                        child: Container(
                          width: Dimensions.width28,
                          height: Dimensions.height15,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/menu.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // logo
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          width: Dimensions.width50 + Dimensions.width5,
                          height: Dimensions.height50 + Dimensions.height5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/logo2.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // search
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Get.toNamed(AppRoutes.getSearchProductsScreen());
                        },
                        child: Container(
                          width: Dimensions.width20 + Dimensions.width5,
                          height: Dimensions.height20 + Dimensions.height5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/search.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height15,
                ),
                // line
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width15 * 4,
                  ),
                  width: double.maxFinite,
                  color: AppColors.mainColor,
                  height: 0.5,
                ),
                // space
                Spacing(
                  height: Dimensions.height30,
                ),
                // links
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                  ),
                  width: double.maxFinite,
                  height: Dimensions.height10 * 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // seeds
                      Column(
                        children: [
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _switchPage(0);
                            },
                            child: Container(
                              height: Dimensions.height50 + Dimensions.height5,
                              width:
                                  (Dimensions.width15 * 4) + Dimensions.width15,
                              decoration: _selectedPage == 0
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bg1.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.height28,
                                    width: Dimensions.width28,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _selectedPage == 0
                                              ? 'assets/images/seeds2.png'
                                              : 'assets/images/seeds.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Seeds',
                                    style: TextStyle(
                                      color: _selectedPage == 0
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimensions.font14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // indica
                      Column(
                        children: [
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _switchPage(1);
                            },
                            child: Container(
                              height: Dimensions.height50 + Dimensions.height5,
                              width:
                                  (Dimensions.width15 * 4) + Dimensions.width15,
                              decoration: _selectedPage == 1
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bg1.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.height28,
                                    width: Dimensions.width28,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _selectedPage == 1
                                              ? 'assets/images/indica2.png'
                                              : 'assets/images/indica.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Indica',
                                    style: TextStyle(
                                      color: _selectedPage == 1
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimensions.font14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                        ],
                      ),
                      // home
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _switchPage(2);
                            },
                            child: Container(
                              height: Dimensions.height50 + Dimensions.height5,
                              width:
                                  (Dimensions.width15 * 4) + Dimensions.width15,
                              decoration: _selectedPage == 2
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bg1.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.height28,
                                    width: Dimensions.width28,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _selectedPage == 2
                                              ? 'assets/images/home.png'
                                              : 'assets/images/home2.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // sativa
                      Column(
                        children: [
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _switchPage(3);
                            },
                            child: Container(
                              height: Dimensions.height50 + Dimensions.height5,
                              width:
                                  (Dimensions.width15 * 4) + Dimensions.width15,
                              decoration: _selectedPage == 3
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bg1.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.height28,
                                    width: Dimensions.width28,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _selectedPage == 3
                                              ? 'assets/images/sativa2.png'
                                              : 'assets/images/sativa.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Sativa',
                                    style: TextStyle(
                                      color: _selectedPage == 3
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimensions.font14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                        ],
                      ),
                      // hybrid
                      Column(
                        children: [
                          // space
                          const Expanded(
                            child: Spacing(),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              _switchPage(4);
                            },
                            child: Container(
                              height: Dimensions.height50 + Dimensions.height5,
                              width:
                                  (Dimensions.width15 * 4) + Dimensions.width15,
                              decoration: _selectedPage == 4
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/bg1.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius20,
                                      ),
                                      border: Border.all(
                                        color: AppColors.mainColor,
                                        width: 1.5,
                                      ),
                                    ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Dimensions.height28,
                                    width: Dimensions.width28,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          _selectedPage == 4
                                              ? 'assets/images/hybrid2.png'
                                              : 'assets/images/hybrid.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Hybrid',
                                    style: TextStyle(
                                      color: _selectedPage == 4
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimensions.font14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height30,
                ),
                // banner
                if (_selectedPage == 2)
                   HomeBanner(
                     orderHybrid: orderSpecialHybrid,
                   ),
                // text
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width30,
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedPage == 2
                            ? 'Recommended'
                            : 'Popular this week',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ],
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height15,
                ),
                // popular
                PopularRecommendedProducts(
                  products: products,
                ),
                // space
                Spacing(
                  height: Dimensions.height15,
                ),
                // products
                Container(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
