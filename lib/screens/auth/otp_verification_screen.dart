import 'dart:async';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:faded_dreamers/widgets/otp_fields.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  AuthController authController = Get.find<AuthController>();

  bool _isLoading = false;

  late String Function() retrieveOtpValue;

  late Timer _timer;
  int _timeLeft = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    startTimer();
  }

  void startTimer() {
    _timeLeft = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  Future<void> resendCode() async {

    if (_canResend) {
      setState(() {
        _isLoading = true;
      });
      // if (await authController.resendOTP()) {
      //   startTimer();
      // }

      startTimer();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    super.dispose();
  }

  void setRetrieveOtpValueFunction(String Function() func) {
    retrieveOtpValue = func;
  }

  void onOtpComplete(String otpCode) {
    verifyCode();
  }

  Future<void> verifyCode() async {
    FocusScope.of(context).unfocus();
    String otp = retrieveOtpValue();
    if (otp.length < 4) {
      Get.snackbar('OTP', 'OTP should be 4 digits');
    } else {
      setState(() {
        _isLoading = true;
      });

      Get.toNamed(AppRoutes.getContactInfoScreen());
      // await authController.verifyOTP(otp: otp);

      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // space
                Spacing(
                  height: Dimensions.height150,
                ),
                // otp send image
                Center(
                  child: Container(
                    height: (Dimensions.height100 * 2) +
                        ((Dimensions.height300 / 10) + 3),
                    width: (Dimensions.width22) * 10,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/otp_sent.png',
                        ),
                      ),
                    ),
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height50,
                ),
                // otp verification
                const Center(
                  child: BigText(
                    text: 'OTP Verification',
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height20,
                ),
                // text
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText(
                          text: 'Enter the OTP sent to',
                          fontWeight: FontWeight.w300,
                          fontSize: Dimensions.font16,
                        ),
                        const Spacing(),
                        BigText(
                          text: 'bishopolumayor.com.ng',
                          fontSize: Dimensions.font16,
                        ),
                      ],
                    ),
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height40,
                ),
                // otp fields
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width40),
                  child: OTPFields(
                    onOtpCompleted: onOtpComplete,
                    getOtpValue: setRetrieveOtpValueFunction,
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height20,
                ),
                // resend
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width40),
                  child: GestureDetector(
                    onTap: (){
                      HapticFeedback.lightImpact();
                      resendCode();
                    },
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Didn\'t receive the OTP? ',
                            style: TextStyle(
                              color: AppColors.greyColor1,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: Dimensions.font16,
                            ),
                          ),
                          TextSpan(
                            text: 'Resend OTP ',
                            style: TextStyle(
                              color: _canResend ? AppColors.secondaryColor : AppColors.greyColor1,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: Dimensions.font16,
                            ),
                          ),
                          TextSpan(
                            text: '$_timeLeft secs',
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height40,
                ),
                // verify
                GestureDetector(
                  onTap: (){
                    HapticFeedback.lightImpact();
                    verifyCode();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.width50),
                    height: Dimensions.height15 * 5,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/bg1.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Verify',
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
                // space
                Spacing(
                  height: Dimensions.height40,
                ),
              ],
            ),
          ),
          if(_isLoading)
            const Center(
              child: BarLoadingAnimation(),
            ),
        ],
      ),
    );
  }
}

