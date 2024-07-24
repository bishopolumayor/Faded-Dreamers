import 'dart:async';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/screens/home/pages/cart_page.dart';
import 'package:faded_dreamers/screens/home/pages/home_page.dart';
import 'package:faded_dreamers/screens/home/pages/orders_page.dart';
import 'package:faded_dreamers/screens/home/pages/profile_page.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/otp_fields.dart';
import 'package:faded_dreamers/widgets/side_bar.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    _pages = <Widget>[
      HomePage(openSidebar: openSidebar),
      const ProfilePage(),
      const OrdersPage(),
      const CartPage(),
    ];

    initializeHomeScreen();
  }

  void initializeHomeScreen() async {
    await authController.showConsent();
    if (productsController.allProducts.isEmpty) {
      await productsController.getProducts();
      await productsController.getFavouriteProducts();
    } else {
      await productsController.getFavouriteProducts();
    }
  }

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    if (index >= 0 && index <= 3) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 4) {
    } else if (index == 5) {
      Get.toNamed(AppRoutes.getFavoriteProducts());
    }else if (index == 6) {
      Get.toNamed(AppRoutes.getFAQScreen());
    }else if (index == 7){
      Get.toNamed(AppRoutes.getNotificationsScreen());
    }
    _scaffoldKey.currentState?.closeDrawer();
  }

  void openSidebar() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeSideBar() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      drawer: SideBar(
        onItemTapped: _onItemTapped,
        closeSideBar: closeSideBar,
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: Dimensions.height100 + Dimensions.height5,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.tertiaryColor,
              AppColors.blackColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.45),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(-5, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // home
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // icon
                    GestureDetector(
                      onTap: () => _onItemTapped(0),
                      child: Container(
                        height: Dimensions.height40 + Dimensions.height5,
                        width: Dimensions.width40 + Dimensions.width5,
                        decoration: _selectedIndex == 0
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bg1.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const BoxDecoration(),
                        child: Center(
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.width40,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/home.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // space
                    const SizedBox(
                      height: 2,
                    ),
                    // label
                    Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // profile
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // icon
                    GestureDetector(
                      onTap: () => _onItemTapped(1),
                      child: Container(
                        height: Dimensions.height40 + Dimensions.height5,
                        width: Dimensions.width40 + Dimensions.width5,
                        decoration: _selectedIndex == 1
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bg1.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const BoxDecoration(),
                        child: Center(
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.width40,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // space
                    const SizedBox(
                      height: 2,
                    ),
                    // label
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // delivery
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // icon
                    GestureDetector(
                      onTap: () => _onItemTapped(2),
                      child: Container(
                        height: Dimensions.height40 + Dimensions.height5,
                        width: Dimensions.width40 + Dimensions.width5,
                        decoration: _selectedIndex == 2
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bg1.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const BoxDecoration(),
                        child: Center(
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.width40,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/delivery.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // space
                    const SizedBox(
                      height: 2,
                    ),
                    // label
                    Text(
                      'Orders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                // cart
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // icon
                    GestureDetector(
                      onTap: () => _onItemTapped(3),
                      child: Container(
                        height: Dimensions.height40 + Dimensions.height5,
                        width: Dimensions.width40 + Dimensions.width5,
                        decoration: _selectedIndex == 3
                            ? const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bg1.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const BoxDecoration(),
                        child: Center(
                          child: Container(
                            height: Dimensions.height40,
                            width: Dimensions.width40,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/cart.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // space
                    const SizedBox(
                      height: 2,
                    ),
                    // label
                    Text(
                      'Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // space
            SizedBox(
              height: Dimensions.height10,
            ),
          ],
        ),
      ),
    );
  }
}
