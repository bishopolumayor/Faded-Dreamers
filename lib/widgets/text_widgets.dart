import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const BigText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.textBlackColor,
        fontFamily: fontFamily ?? 'Inter',
        fontSize: fontSize ?? Dimensions.font23,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const NormalText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.blackColor,
        fontFamily: fontFamily ?? 'Inter',
        fontSize: fontSize ?? Dimensions.font18,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const SmallText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.blackColor,
        fontFamily: fontFamily ?? 'Inter',
        fontSize: fontSize ?? Dimensions.font16,
        fontWeight: fontWeight ?? FontWeight.w300,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
