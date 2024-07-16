import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';

class OTPFields extends StatefulWidget {
  final Function(String otpCode) onOtpCompleted;
  final Function(String Function()) getOtpValue;

  const OTPFields({
    Key? key,
    required this.onOtpCompleted,
    required this.getOtpValue,
  }) : super(key: key);

  @override
  _OTPFieldsState createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  late FocusNode pin1FocusNode;
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late TextEditingController pin1Controller;
  late TextEditingController pin2Controller;
  late TextEditingController pin3Controller;
  late TextEditingController pin4Controller;

  @override
  void initState() {
    super.initState();
    widget.getOtpValue(_getOtpValue);
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin1Controller = TextEditingController();
    pin2Controller = TextEditingController();
    pin3Controller = TextEditingController();
    pin4Controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin1Controller.dispose();
    pin2Controller.dispose();
    pin3Controller.dispose();
    pin4Controller.dispose();
  }

  void nextField({required String value, FocusNode? focusNode}) {
    if (value.length == 1 && focusNode != null) {
      focusNode.requestFocus();
    }
  }

  void verifyOTP() {
    if (pin1Controller.text.length == 1 &&
        pin2Controller.text.length == 1 &&
        pin3Controller.text.length == 1 &&
        pin4Controller.text.length == 1) {
      String otpCode = pin1Controller.text +
          pin2Controller.text +
          pin3Controller.text +
          pin4Controller.text;
      print(otpCode);
      widget.onOtpCompleted(otpCode);
    }
  }

  String _getOtpValue() {
    return pin1Controller.text +
        pin2Controller.text +
        pin3Controller.text +
        pin4Controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: AutofillGroup(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildOTPField(
              context,
              pin1Controller,
              pin1FocusNode,
              pin2FocusNode,
              'oneTimeCode',
            ),
            buildOTPField(
              context,
              pin2Controller,
              pin2FocusNode,
              pin3FocusNode,
              'oneTimeCode',
            ),
            buildOTPField(
              context,
              pin3Controller,
              pin3FocusNode,
              pin4FocusNode,
              'oneTimeCode',
            ),
            buildOTPField(
                context, pin4Controller, pin4FocusNode, null, 'oneTimeCode'),
          ],
        ),
      ),
    );
  }

  Widget buildOTPField(BuildContext context, TextEditingController controller,
      FocusNode? currentFocus, FocusNode? nextFocus, String autofillHint) {
    return SizedBox(
      width: Dimensions.width52,
      height: Dimensions.height52,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyUpEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            if (currentFocus == pin2FocusNode &&
                pin1Controller.text.isNotEmpty) {
              pin1Controller.clear();
              FocusScope.of(context).requestFocus(pin1FocusNode);
            } else if (currentFocus == pin3FocusNode &&
                pin2Controller.text.isNotEmpty) {
              pin2Controller.clear();
              FocusScope.of(context).requestFocus(pin2FocusNode);
            } else if (currentFocus == pin4FocusNode &&
                pin3Controller.text.isNotEmpty) {
              pin3Controller.clear();
              FocusScope.of(context).requestFocus(pin3FocusNode);
            }
          }
          if (event is RawKeyUpEvent &&
              event.logicalKey == LogicalKeyboardKey.delete &&
              controller.text.isEmpty) {
            if (currentFocus == pin2FocusNode &&
                pin1Controller.text.isNotEmpty) {
              pin1Controller.clear();
              FocusScope.of(context).requestFocus(pin1FocusNode);
            } else if (currentFocus == pin3FocusNode &&
                pin2Controller.text.isNotEmpty) {
              pin2Controller.clear();
              FocusScope.of(context).requestFocus(pin2FocusNode);
            } else if (currentFocus == pin4FocusNode &&
                pin3Controller.text.isNotEmpty) {
              pin3Controller.clear();
              FocusScope.of(context).requestFocus(pin3FocusNode);
            }
          }
        },
        child: TextFormField(
          controller: controller,
          autofocus: true,
          style: TextStyle(
            fontSize: Dimensions.font23,
          ),
          keyboardType: TextInputType.number,
          cursorColor: AppColors.mainColor,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(
            //   vertical: Dimensions.height15,
            // ),
            contentPadding: EdgeInsets.zero,
            hintText: '0',
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.25),
              fontSize: Dimensions.font23,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
                width: 1,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mainColor,
                width: 1.5,
              ),
            ),
            counterText: "",
          ),
          maxLength: 1,
          autofillHints: [autofillHint],
          onEditingComplete: nextFocus == null ? verifyOTP : null,
          onChanged: (value) {
            if (value.length == 1) {
              if (nextFocus != null) {
                nextField(value: value, focusNode: nextFocus);
              } else {
                verifyOTP();
              }
            }
          },
          focusNode: currentFocus,
        ),
      ),
    );
  }
}
