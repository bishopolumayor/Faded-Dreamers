import 'dart:io';

import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/user_model.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();

  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();

  File? _selfieImage;

  bool isEdit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeProfile();
  }

  void initializeProfile() async {
    UserModel user = userController.user.value!;

    setState(() {
      fullNameController.text = '${user.firstName} ${user.lastName}';
      addressController.text = user.address ?? '';
      cityController.text = user.city ?? '';
      stateController.text = user.state ?? '';
      countryController.text = user.country ?? '';
    });
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      final fileSize = await imageFile.length();
      if (kDebugMode) {
        print("Original file size: ${fileSize / 1024} KB");
      }

      if (fileSize > 50 * 1024) {
        File? compressedImage = await compressImage(pickedFile.path);
        if (compressedImage != null) {
          setState(() {
            _selfieImage = compressedImage;
          });
          uploadImage();
        }
      } else {
        setState(() {
          _selfieImage = imageFile;
        });
        uploadImage();
      }
    }
  }

  void uploadImage() async {
    if (_selfieImage != null) {
      setState(() {
        _isLoading = true;
      });
      await authController.uploadSelfie(
        selfieImage: _selfieImage!,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<File?> compressImage(String path) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      path,
      path.replaceFirst('.jpg', '_compressed.jpg'),
      quality: 10,
    );

    if (result != null) {
      final compressedSize = await result.length();
      if (kDebugMode) {
        print("Compressed file size: ${compressedSize / 1024} KB");
      }
      return File(result.path);
    }

    return null;
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

  void save() async {
    if (isEdit == true) {
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
          isEdit = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Stack(
              children: [
                // bg
                Positioned(
                  top: Dimensions.height150 + Dimensions.height50,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height150 * 6,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueWhite,
                      // color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius30 * 2),
                    ),
                  ),
                ),
                // others
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // space
                    Spacing(
                      height: Dimensions.height70,
                    ),
                    // back and profile // edit/save
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // back
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                          },
                          child: Container(
                            width: Dimensions.width30,
                            height: Dimensions.height22,
                            decoration: const BoxDecoration(
                                /*image: DecorationImage(
                            image: AssetImage(
                              'assets/images/back2.png',
                            ),
                          ),*/
                                ),
                          ),
                        ),
                        // profile
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                          },
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // edit/save
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            if (isEdit) {
                              save();
                            } else {
                              setState(() {
                                isEdit = true;
                              });
                            }
                          },
                          child: Text(
                            isEdit ? 'Save' : 'Edit',
                            style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: Dimensions.font18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // space
                    Spacing(
                      height: Dimensions.height20 * 11,
                    ),
                    // text fields
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // full name
                          Text(
                            'Full Name',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: Dimensions.font14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // spacing
                          Spacing(
                            height: Dimensions.height15,
                          ),
                          // text field
                          SizedBox(
                            height: Dimensions.height10 * 5,
                            child: TextField(
                              controller: fullNameController,
                              keyboardType: TextInputType.name,
                              cursorColor: AppColors.blackColor,
                              textAlignVertical: TextAlignVertical.center,
                              enabled: isEdit,
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
                            height: Dimensions.height15,
                          ),
                          // Address
                          Text(
                            'Address',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: Dimensions.font14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // spacing
                          Spacing(
                            height: Dimensions.height10,
                          ),
                          // text field
                          SizedBox(
                            height: Dimensions.height10 * 5,
                            child: TextField(
                              controller: addressController,
                              keyboardType: TextInputType.name,
                              cursorColor: AppColors.blackColor,
                              enabled: isEdit,
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
                            height: Dimensions.height15,
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
                                    Text(
                                      'City',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: Dimensions.font14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // spacing
                                    Spacing(
                                      height: Dimensions.height10,
                                    ),
                                    // text field
                                    SizedBox(
                                      height: Dimensions.height10 * 5,
                                      child: TextField(
                                        controller: cityController,
                                        keyboardType: TextInputType.name,
                                        cursorColor: AppColors.blackColor,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        enabled: isEdit,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    Text(
                                      'State',
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: Dimensions.font14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // spacing
                                    Spacing(
                                      height: Dimensions.height10,
                                    ),
                                    // text field
                                    SizedBox(
                                      height: Dimensions.height10 * 5,
                                      child: TextField(
                                        controller: stateController,
                                        keyboardType: TextInputType.name,
                                        cursorColor: AppColors.blackColor,
                                        enabled: isEdit,
                                        textAlignVertical:
                                            TextAlignVertical.center,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                            height: Dimensions.height15,
                          ),
                          // country
                          Text(
                            'Country',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: Dimensions.font14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // spacing
                          Spacing(
                            height: Dimensions.height10,
                          ),
                          // text field
                          SizedBox(
                            height: Dimensions.height10 * 5,
                            child: TextField(
                              controller: countryController,
                              keyboardType: TextInputType.name,
                              cursorColor: AppColors.blackColor,
                              enabled: isEdit,
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
                            height: Dimensions.height70,
                          ),
                          // save
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              save();
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.width40,
                              ),
                              height: Dimensions.height40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/bg1.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // spacing
                          Spacing(
                            height: Dimensions.height50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // profile image
                Positioned(
                  top: Dimensions.height134,
                  left: (Dimensions.screenWidth -
                          Dimensions.height150 -
                          Dimensions.width20) /
                      2,
                  child: Obx(() {
                    UserModel user = userController.user.value!;
                    return Container(
                      height: Dimensions.height150,
                      width: Dimensions.height150,
                      child: Stack(
                        children: [
                          Container(
                            height: Dimensions.height150,
                            width: Dimensions.height150,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/bg1.png',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: _selfieImage != null
                                  ? Container(
                                      height: Dimensions.height150 -
                                          (Dimensions.height20),
                                      width: Dimensions.height150 -
                                          (Dimensions.height20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.whiteColor,
                                        image: DecorationImage(
                                          image: FileImage(_selfieImage!),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: Dimensions.height150 -
                                          (Dimensions.height20),
                                      width: Dimensions.height150 -
                                          (Dimensions.height20),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.whiteColor,
                                        image: DecorationImage(
                                          image: user.avatarUrl != null
                                              ? user.avatarUrl!.isNotEmpty
                                                  ? NetworkImage(
                                                      user.avatarUrl!)
                                                  : const AssetImage(
                                                      'assets/images/dp.png',
                                                    ) as ImageProvider
                                              : const AssetImage(
                                                  'assets/images/dp.png',
                                                ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            right: Dimensions.width10,
                            bottom: Dimensions.height10,
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                _pickImage();
                              },
                              child: Container(
                                  height: Dimensions.height30,
                                  width: Dimensions.width30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.whiteColor,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/cam.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          const Center(
            child: BarLoadingAnimation(),
          ),
      ],
    );
  }
}
