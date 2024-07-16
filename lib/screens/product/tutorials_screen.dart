import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TutorialsScreen extends StatefulWidget {
  const TutorialsScreen({super.key});

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {

  bool _isLoading = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          Column(
            children: [
              // space
              Spacing(
                height: Dimensions.height70,
              ),
              // back and pluto
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.width40,
                ),
                child: Row(
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
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/back.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    // tutorial
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      child: Text(
                        'Tutorial',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: Dimensions.font18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // search
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      child: Container(
                        width: Dimensions.width20 + Dimensions.width5,
                        height: Dimensions.height20 + Dimensions.height5,
                        decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     'assets/images/search.png',
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // loading
              if (_isLoading)
                const LinearProgressIndicator(
                  color: AppColors.mainColor,
                ),
              // space
              Spacing(
                height: Dimensions.height20,
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius30 * 2),
                      topLeft: Radius.circular(Dimensions.radius30 * 2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacing(
                        height: Dimensions.height100 * 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
