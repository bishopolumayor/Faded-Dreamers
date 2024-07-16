import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController authController = Get.find<AuthController>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

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
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        usernameController.text.isEmpty) {
      Get.snackbar(
        'Incomplete inputs',
        'fill in all input fields',
      );
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Invalid Input',
        'Enter a valid email',
      );
      return false;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Invalid Input',
        'Password must be at least 6 characters long',
      );
      return false;
    }
    return true;
  }

  void signUp() async {
    if (validate()) {
      setState(() {
        _isLoading = true;
      });
      await authController.signUp(
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      // Get.toNamed(AppRoutes.getOTPVerificationScreen());
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
                // welcome
                Center(
                  child: Text(
                    'Welcome!',
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
                  height: Dimensions.height10 / 5,
                ),
                // sign up to continue
                Center(
                  child: Text(
                    'Sign Up to continue',
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
                  height: Dimensions.height40,
                ),
                // username text field
                Container(
                  height: Dimensions.height15 * 4,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width40,
                  ),
                  child: TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
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
                            /*decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/password.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),*/
                          ),
                        ],
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: AppColors.greyColor1,
                        fontFamily: 'Inter',
                        fontSize: Dimensions.font18,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: 'Inter',
                      fontSize: Dimensions.font18,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height40,
                ),
                // password text field
                Container(
                  height: Dimensions.height15 * 4,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width40,
                  ),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: AppColors.blackColor,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: true,
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
                                  'assets/images/password.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: AppColors.greyColor1,
                        fontFamily: 'Inter',
                        fontSize: Dimensions.font18,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontFamily: 'Inter',
                      fontSize: Dimensions.font18,
                    ),
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height15 * 3,
                ),
                // sign up
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    signUp();
                  },
                  child: Center(
                    child: Container(
                      height: Dimensions.height15 * 4,
                      width: Dimensions.width188,
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
                          'SIGN UP',
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
                // space
                SizedBox(
                  height: Dimensions.height15 * 2,
                ),
                // have account
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.offNamed(AppRoutes.getSignInScreen());
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have Account? ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.font18,
                            fontFamily: 'Inter',
                          ),
                        ),
                        TextSpan(
                          text: 'Log In',
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
