import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentCompleteScreen extends StatelessWidget {
  const PaymentCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: Dimensions.width240,
              height: Dimensions.height100 + Dimensions.height28,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/big_check.png'),
                ),
              ),
            ),
          ),
          Spacing(
            height: Dimensions.height20,
          ),
          Center(
            child: Container(
              width: Dimensions.width240 + Dimensions.width10,
                height: Dimensions.width240 + Dimensions.width10,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/rider.png'),
                ),
              ),
            ),
          ),
          Spacing(
            height: Dimensions.height20,
          ),
          Center(
            child: GestureDetector(
              onTap: (){
                HapticFeedback.lightImpact();
                Get.offNamed(AppRoutes.getHomeScreen());
              },
              child: Container(
                height: Dimensions.height40,
                width: Dimensions.width22 * 10,
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Go back Home',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: Dimensions.font16
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
