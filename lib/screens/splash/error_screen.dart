import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {

  void retry() {
    Get.offAllNamed(AppRoutes.getSplashScreen());
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
               Icon(
                Icons.error_outline_outlined,
                color: AppColors.whiteColor,
                size: Dimensions.iconSize24 * 5,
              ),
              Spacing(
                height: Dimensions.height20,
              ),
             GestureDetector(
               onTap: (){
                 HapticFeedback.heavyImpact();
                 retry();
               },
               child:  Container(
                 padding: EdgeInsets.symmetric(
                     horizontal: Dimensions.width30,
                     vertical: Dimensions.height10
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(Dimensions.radius10),
                   color: AppColors.whiteColor,
                 ),
                 child: Text(
                   'Retry',
                   style: TextStyle(
                     fontSize: Dimensions.font20,
                     fontWeight: FontWeight.w700,
                     fontFamily: 'Inter',
                     color: AppColors.mainColor,
                   ),
                 ),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
