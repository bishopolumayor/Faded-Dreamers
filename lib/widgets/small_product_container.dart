import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SmallProductContainer extends StatelessWidget {
  final ProductModel product;

  const SmallProductContainer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Get.toNamed(
          AppRoutes.getProductDetailScreen(),
          arguments: product,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
        ),
        height: Dimensions.height100 + Dimensions.height15,
        width: Dimensions.width20 * 4,
        child: Stack(
          children: [
            Positioned(
              top: Dimensions.height30 + Dimensions.height5,
              right: 3,
              left: 3,
              child: Container(
                // width: Dimensions.width15 * 4,
                height: Dimensions.height70 + Dimensions.height5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius30,
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimensions.font26 / 3,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Spacing(
                      height: Dimensions.height15,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                width: Dimensions.height70 + Dimensions.height5,
                height: Dimensions.height70 + Dimensions.height5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(product.images[0].src),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Dimensions.height15,
              right: Dimensions.width15,
              left: Dimensions.width15,
              child: Container(
                height: Dimensions.height15,
                width: Dimensions.width20 * 2,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius15,
                  ),
                ),
                child: Center(
                  child: Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.whiteColor,
                      fontSize: Dimensions.font18 / 2,
                      fontWeight: FontWeight.w600,
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
