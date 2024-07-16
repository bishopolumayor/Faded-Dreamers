import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';

class Spacing extends StatelessWidget {
  final double? height;
  final double? width;

  const Spacing({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.height10,
      width: width ?? Dimensions.width10,
    );
  }
}
