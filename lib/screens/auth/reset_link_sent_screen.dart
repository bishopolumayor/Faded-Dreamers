import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResetLinkSentScreen extends StatefulWidget {

  const ResetLinkSentScreen({super.key});

  @override
  State<ResetLinkSentScreen> createState() => _ResetLinkSentScreenState();
}

class _ResetLinkSentScreenState extends State<ResetLinkSentScreen> {
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // bg and logo
          Stack(
            children: [
              // bg
              Container(
                height: Dimensions.height240 + Dimensions.height15,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/bg2.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // logo
              Container(
                height: Dimensions.height22 * 13,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo1.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          // space
          SizedBox(
            height: Dimensions.height40,
          ),
          // mail image
          Container(
            height: Dimensions.height100,
            width: Dimensions.width100,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/email.png',),),
            ),
          ),
          // space
          SizedBox(
            height: Dimensions.height40,
          ),
          // we have sent a mail to ...
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Obx(()  {
              return Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'We have sent a mail\nto ',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w300,
                        fontSize: Dimensions.font18,
                        fontFamily: 'Inter',
                      ),
                    ),
                    TextSpan(
                      text: authController.resetPasswordEmail.value,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18,
                        fontFamily: 'Inter',
                      ),
                    ),
                    TextSpan(
                      text: ' with instructions to reset your password',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w300,
                        fontSize: Dimensions.font18,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          // space
          SizedBox(
            height: Dimensions.height15 * 3,
          ),
          // back to login
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Get.offAllNamed(AppRoutes.getSignInScreen());
            },
            child: Center(
              child: Container(
                height: Dimensions.height15 * 4,
                width: Dimensions.width28 * 10,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius30),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                        'BACK TO LOGIN',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontFamily: 'Inter',
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
