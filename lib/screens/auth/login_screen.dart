import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find<AuthController>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Incomplete inputs',
        'fill in all input fields',
      );
      return false;
    }
    return true;
  }

  void login() async {
    if (validate()) {
      setState(() {
        _isLoading = true;
      });
      await authController.login(
        login: emailController.text,
        password: passwordController.text,
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
                // login to continue
                Center(
                  child: Text(
                    'Log in to continue',
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
                      hintText: 'Email Address/Username',
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
                  height: Dimensions.height20,
                ),
                // forgot Password
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.toNamed(AppRoutes.getResetPasswordScreen());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: Dimensions.font18,
                            fontWeight: FontWeight.w300,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // space
                SizedBox(
                  height: Dimensions.height15 * 3,
                ),
                // login
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    login();
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
                          'LOG IN',
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
