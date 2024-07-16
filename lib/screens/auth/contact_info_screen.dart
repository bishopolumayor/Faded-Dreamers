import 'dart:async';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/otp_fields.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/bar_loading_animation.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  AuthController authController = Get.find<AuthController>();

  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();

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
    if (fullNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        countryController.text.isEmpty) {
      Get.snackbar(
        'Incomplete inputs',
        'Please fill in all details',
      );
      return false;
    }
    return true;
  }

  void complete() async {
    if (validate()) {
      setState(() {
        _isLoading = true;
      });
      await authController.updateInfo(
        fullName: fullNameController.text,
        address: addressController.text,
        country: countryController.text,
        state: stateController.text,
        city: cityController.text,
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg1.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // space
                  Spacing(
                    height: Dimensions.height70,
                  ),
                  // back and contact information
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Get.back();
                        },
                        child: Container(
                          height: Dimensions.height22,
                          width: Dimensions.width28,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/back.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // contact information
                      const BigText(
                        text: 'Contact\nInformation',
                        color: AppColors.whiteColor,
                      ),
                      // spacing
                      Spacing(
                        width: Dimensions.width28,
                      ),
                    ],
                  ),
                  // space
                  Spacing(
                    height: Dimensions.height50,
                  ),
                  // full name
                  const NormalText(
                    text: 'Full Name',
                    color: AppColors.skyBlue,
                  ),
                  // spacing
                  Spacing(
                    height: Dimensions.height15,
                  ),
                  // text field
                  SizedBox(
                    height: Dimensions.height15 * 4,
                    child: TextField(
                      controller: fullNameController,
                      keyboardType: TextInputType.name,
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
                        fillColor: AppColors.whiteColor,
                        prefixIcon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        hintText: 'Full name',
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
                  Spacing(
                    height: Dimensions.height28,
                  ),
                  // Address
                  const NormalText(
                    text: 'Address',
                    color: AppColors.skyBlue,
                  ),
                  // spacing
                  Spacing(
                    height: Dimensions.height15,
                  ),
                  // text field
                  SizedBox(
                    height: Dimensions.height15 * 4,
                    child: TextField(
                      controller: addressController,
                      keyboardType: TextInputType.name,
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
                        fillColor: AppColors.whiteColor,
                        prefixIcon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        hintText: 'Home Address',
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
                  Spacing(
                    height: Dimensions.height28,
                  ),
                  //
                  Row(
                    children: [
                      // city
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // city
                            const NormalText(
                              text: 'City',
                              color: AppColors.skyBlue,
                            ),
                            // spacing
                            Spacing(
                              height: Dimensions.height15,
                            ),
                            // text field
                            SizedBox(
                              height: Dimensions.height15 * 4,
                              child: TextField(
                                controller: cityController,
                                keyboardType: TextInputType.name,
                                cursorColor: AppColors.blackColor,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius45),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius45),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  prefixIcon: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [],
                                  ),
                                  hintText: 'City',
                                  hintStyle: TextStyle(
                                    color: AppColors.greyColor1,
                                    fontFamily: 'Inter',
                                    fontSize: Dimensions.font18,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // space
                      Spacing(
                        width: Dimensions.width20,
                      ),
                      // state
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // state
                            const NormalText(
                              text: 'State',
                              color: AppColors.skyBlue,
                            ),
                            // spacing
                            Spacing(
                              height: Dimensions.height15,
                            ),
                            // text field
                            SizedBox(
                              height: Dimensions.height15 * 4,
                              child: TextField(
                                controller: stateController,
                                keyboardType: TextInputType.name,
                                cursorColor: AppColors.blackColor,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius45),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius45),
                                    borderSide: const BorderSide(
                                      width: 1,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  prefixIcon: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [],
                                  ),
                                  hintText: 'State',
                                  hintStyle: TextStyle(
                                    color: AppColors.greyColor1,
                                    fontFamily: 'Inter',
                                    fontSize: Dimensions.font18,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // space
                  Spacing(
                    height: Dimensions.height28,
                  ),
                  // country
                  const NormalText(
                    text: 'Country',
                    color: AppColors.skyBlue,
                  ),
                  // spacing
                  Spacing(
                    height: Dimensions.height15,
                  ),
                  // text field
                  SizedBox(
                    height: Dimensions.height15 * 4,
                    child: TextField(
                      controller: countryController,
                      keyboardType: TextInputType.name,
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
                        fillColor: AppColors.whiteColor,
                        prefixIcon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        hintText: 'Country',
                        hintStyle: TextStyle(
                          color: AppColors.greyColor1,
                          fontFamily: 'Inter',
                          fontSize: Dimensions.font18,
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  // spacing
                  Spacing(
                    height: Dimensions.height100,
                  ),
                  // complete
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      complete();
                    },
                    child: Container(
                      height: Dimensions.height15 * 4,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // complete
                            const BigText(
                              text: 'Complete',
                            ),
                            // space
                            const Spacing(),
                            // check
                            Container(
                              height: Dimensions.height15,
                              width: Dimensions.width20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/check.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // spacing
                  Spacing(
                    height: Dimensions.height100,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: BarLoadingAnimation(
                color: AppColors.whiteColor,
              ),
            ),
        ],
      ),
    );
  }
}
