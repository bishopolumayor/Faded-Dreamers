import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  AuthController authController = Get.find<AuthController>();

  var emailController = TextEditingController();

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

  bool validate() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Incomplete inputs',
        'Enter your email',
      );
      return false;
    }
    if(!GetUtils.isEmail(emailController.text)){
      Get.snackbar(
        'Invalid inputs',
        'Enter a valid mail',
      );
      return false;
    }
    return true;
  }

  void resetPassword() async {
    if (validate()) {
      setState(() {
        _isLoading = true;
      });
      await authController.resetPassword(
        email: emailController.text,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                  height: Dimensions.height10,
                ),
                // reset password
                Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w800,
                      fontSize: Dimensions.font23,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height10,
                ),
                // we will email you
                Center(
                  child: Text(
                    'We will email you\na link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: Dimensions.font18,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height40,
                ),
                // email text field
                Container(
                  height: Dimensions.height15 * 4,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width40,
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppColors.blackColor,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius45),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius45),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.mainColor,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.lightBlueWhite,
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: Dimensions.height20 + Dimensions.height5,
                            width: Dimensions.width20 + Dimensions.width5,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/mail.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        color: AppColors.greyColor1,
                        fontFamily: 'Inter',
                        fontSize: Dimensions.font18,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height15 * 3,
                ),
                // reset
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    resetPassword();
                  },
                  child: Center(
                    child: Container(
                      height: Dimensions.height15 * 4,
                      width: Dimensions.width20 * 10,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(_isLoading)
                                  Container(
                                    height: Dimensions.height24,
                                    width: Dimensions.width24,
                                    margin: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height10,
                                      right: Dimensions.width10,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                        backgroundColor: AppColors.mainColor,
                                      ),
                                    ),
                                  ),
                            Text(
                              'SEND',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontFamily: 'Inter',
                                fontSize: Dimensions.font18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height15 * 2,
                ),
                // new user
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.offNamed(AppRoutes.getSignUpScreen());
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'New User? ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.font18,
                            fontFamily: 'Inter',
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.font18,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height50,
                ),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: BarLoadingAnimation(),
            ),
        ],
      ),
    );
  }
}
