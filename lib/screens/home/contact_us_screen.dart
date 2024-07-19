import 'package:faded_dreamers/models/faq_model.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var messageController = TextEditingController();

  bool validateInputs() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        messageController.text.isEmpty) {
      Get.snackbar('Incomplete inputs', 'All input fields are compulsory');
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Invalid inputs', 'Enter a valid email address');
      return false;
    }

    return true;
  }

  void sendMessage() {
    if (validateInputs()) {
      Get.snackbar(
        'Success',
        'Your message has been sent successfully',
        colorText: AppColors.whiteColor,
        backgroundColor: AppColors.mainColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top
            SizedBox(
              width: double.maxFinite,
              height: Dimensions.height240 + Dimensions.height15,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height240 + Dimensions.height15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/bg1.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height240 + Dimensions.height15,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: Dimensions.font26 + Dimensions.font10,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height40,
            ),
            // name
            Container(
              height: Dimensions.height15 * 4,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width40,
              ),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.blackColor,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 0.75,
                      color: AppColors.mainColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.mainColor,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.lightBlueWhite,
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: AppColors.greyColor1,
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font18,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Inter',
                  fontSize: Dimensions.font18,
                ),
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // email
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
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 0.75,
                      color: AppColors.mainColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.mainColor,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.lightBlueWhite,
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: AppColors.greyColor1,
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font18,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Inter',
                  fontSize: Dimensions.font18,
                ),
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // phone
            Container(
              height: Dimensions.height15 * 4,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width40,
              ),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.blackColor,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 0.75,
                      color: AppColors.mainColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.mainColor,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.lightBlueWhite,
                  hintText: 'Phone number',
                  hintStyle: TextStyle(
                    color: AppColors.greyColor1,
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font18,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Inter',
                  fontSize: Dimensions.font18,
                ),
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // message
            Container(
              height: Dimensions.height100 + Dimensions.height70,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width40,
              ),
              child: TextField(
                controller: messageController,
                keyboardType: TextInputType.text,
                cursorColor: AppColors.blackColor,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 20,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 0.75,
                      color: AppColors.mainColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: AppColors.mainColor,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.lightBlueWhite,
                  hintText: 'Send us a message...',
                  hintStyle: TextStyle(
                    color: AppColors.greyColor1,
                    fontFamily: 'Inter',
                    fontSize: Dimensions.font18,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20,
                    bottom: Dimensions.height10,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontFamily: 'Inter',
                  fontSize: Dimensions.font18,
                ),
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // send
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                sendMessage();
              },
              child: Center(
                child: Container(
                  height: Dimensions.height15 * 4,
                  width: Dimensions.width240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/bg1.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'SEND',
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
      ),
    );
  }
}
