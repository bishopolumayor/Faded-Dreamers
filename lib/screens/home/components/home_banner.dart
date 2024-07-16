import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/screens/home/components/home_banner.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeBanner extends StatefulWidget {
  final void Function() orderHybrid;
  const HomeBanner({super.key, required this.orderHybrid});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.height150 + Dimensions.height15,
          width: double.maxFinite,
          padding: EdgeInsets.only(
            top: Dimensions.height10,
            bottom: Dimensions.height10,
            left: Dimensions.width20,
            right: Dimensions.width10,
          ),
          color: AppColors.whiteColor,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Introducing',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: Dimensions.font18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacing(),
                    Text(
                      'Spacial Hybrid Packages',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: Dimensions.font20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacing(),
                    GestureDetector(
                      onTap: (){
                        HapticFeedback.lightImpact();
                        widget.orderHybrid();
                      },
                      child: Container(
                        width: Dimensions.width30 * 2 + Dimensions.width10,
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height5,
                        ),
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/bg1.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Order Now',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: Dimensions.font18 /2,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height:
                Dimensions.height150 - Dimensions.height10,
                width: (Dimensions.width20 * 12),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/dummy2.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // space
        Spacing(
          height: Dimensions.height20,
        ),
        // learn
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Do you want to learn how to Roll Trees?',
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacing(),
              Column(
                children: [
                  Spacing(
                    height: Dimensions.height15,
                  ),
                  GestureDetector(
                    onTap: (){
                      HapticFeedback.lightImpact();
                      Get.toNamed(AppRoutes.getTutorialScreen());
                    },
                    child: Container(
                      width: Dimensions.width30 * 2 + Dimensions.width15,
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height10 / 1.5,
                      ),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/bg1.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Get Tutorials',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.font18 /2,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
          height: Dimensions.height15,
        ),
        // line
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width70,
          ),
          height: 0.75,
          width: double.maxFinite,
          color: AppColors.whiteColor,
        ),
        // space
        Spacing(
          height: Dimensions.height15,
        ),
      ],
    );
  }
}
