import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/user_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SideBar extends StatefulWidget {
  final void Function(int) onItemTapped;
  final void Function() closeSideBar;

  const SideBar({super.key, required this.onItemTapped, required this.closeSideBar,});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Dimensions.width30) * 10,
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height70,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.radius45),
        ),
      ),
      child: Column(
        children: [
          // profile image, name, username and cancel
          Obx(() {
              UserModel user = userController.user.value!;
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.width50 / 2,
                ),
                child: Row(
                  children: [
                    // profile image
                    GestureDetector(
                      onTap: (){
                        HapticFeedback.lightImpact();
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: Dimensions.height50,
                            width: Dimensions.width50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius15),
                              image: DecorationImage(
                                image: user.avatarUrl != null
                                    ? user.avatarUrl!.isNotEmpty
                                    ? NetworkImage(
                                    user.avatarUrl!)
                                    : const AssetImage(
                                  'assets/images/dp.png',
                                ) as ImageProvider
                                    : const AssetImage(
                                  'assets/images/dp.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: Dimensions.height10,
                              width: Dimensions.height10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                border: Border.all(
                                  color: AppColors.whiteColor,
                                  width: 1.2,
                                ),
                              ),
                            ),),
                        ],
                      ),
                    ),
                    // space
                    const Spacing(),
                    // name and username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyle(
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            fontSize: Dimensions.font14,
                          ),
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height5,
                        ),
                        // username
                        Text(
                          '@${user.username}',
                          style: TextStyle(
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Inter',
                            fontSize: Dimensions.font12,
                          ),
                        ),
                      ],
                    ),
                    // space
                    const Expanded(
                      child: SizedBox(),
                    ),
                    // cancel button
                    GestureDetector(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        widget.closeSideBar();
                      },
                      child: Container(
                        height: Dimensions.height24,
                        width: Dimensions.width24,
                        decoration:  const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/cancel.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // notifications
          GestureDetector(
            onTap: (){
              widget.onItemTapped(7);
            },
            child: Container(
              child: Row(
                children: [
                  // blue
                  Container(
                    height: Dimensions.height50 + Dimensions.height10,
                    width: Dimensions.width15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius5 / 2),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/bg1.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  //
                  Expanded(
                    child: Container(
                      height: Dimensions.height50 + Dimensions.height10,
                      decoration: const BoxDecoration(
                        color: AppColors.lightBlueWhite,
                      ),
                    child: Row(
                      children: [
                        // spacing
                        Spacing(
                          width: Dimensions.width10,
                        ),
                        // icon
                        Container(
                          height: Dimensions.height28,
                          width: Dimensions.width28,
                          decoration:  const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/notifications.png',
                              ),
                            ),
                          ),
                        ),
                        // space
                        Spacing(
                          width: Dimensions.width20,
                        ),
                        // text
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ],
                    ),
                  ),),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // Track orders
          GestureDetector(
            onTap: (){
              widget.onItemTapped(2);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              child: Row(
                children: [
                  // icon
                  Container(
                    height: Dimensions.height28,
                    width: Dimensions.width28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/delivery2.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // text
                  Text(
                    'Track Orders',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // tutorials
          GestureDetector(
            onTap: (){
              HapticFeedback.lightImpact();
              Get.toNamed(AppRoutes.getTutorialScreen());
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              child: Row(
                children: [
                  // icon
                  Container(
                    height: Dimensions.height28,
                    width: Dimensions.width28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/tuto.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // text
                  Text(
                    'Tutorials',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // cart
          GestureDetector(
            onTap: (){
              widget.onItemTapped(3);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              child: Row(
                children: [
                  // icon
                  Container(
                    height: Dimensions.height28,
                    width: Dimensions.width28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/cart2.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // text
                  Text(
                    'Cart',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // favorites
          GestureDetector(
            onTap: (){
              HapticFeedback.lightImpact();
              widget.onItemTapped(5);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              child: Row(
                children: [
                  // icon
                  Container(
                    height: Dimensions.height28,
                    width: Dimensions.width28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/like2.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // text
                  Text(
                    'Favorites',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // faq
          GestureDetector(
            onTap: (){
              HapticFeedback.lightImpact();
              widget.onItemTapped(6);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              child: Row(
                children: [
                  // icon
                  Container(
                    height: Dimensions.height28,
                    width: Dimensions.width28,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/faq_icon.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // text
                  Text(
                    'FAQ',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.font16,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize16,
                  ),
                ],
              ),
            ),
          ),
          // space
          const Expanded(
            child: SizedBox(),
          ),
          // sign out
          GestureDetector(
            onTap: (){
              HapticFeedback.lightImpact();
              authController.logout();
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width50 / 2,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.height15,
                horizontal: Dimensions.width15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                border: Border.all(
                  color: AppColors.mainColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // sign out
                  Text(
                    'Sign out',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: Dimensions.font18,
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // icon
                  Container(
                    height: Dimensions.height22,
                    width: Dimensions.width22,
                    decoration:  const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/logout.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height100,
          ),
        ],
      ),
    );
  }
}
