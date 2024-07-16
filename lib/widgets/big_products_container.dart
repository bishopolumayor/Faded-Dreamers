import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:faded_dreamers/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BigProductsContainer extends StatefulWidget {
  final ProductModel product;

  const BigProductsContainer({
    super.key,
    required this.product,
  });

  @override
  State<BigProductsContainer> createState() => _BigProductsContainerState();
}

class _BigProductsContainerState extends State<BigProductsContainer> {
  ProductsController productsController = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.product;
    bool fav = productsController.isFavorite(product.id);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Get.toNamed(
          AppRoutes.getProductDetailScreen(),
          arguments: product,
        );
      },
      child: Container(
        width: double.maxFinite,
        height: Dimensions.height100 + Dimensions.height20,
        margin: EdgeInsets.only(
          bottom: Dimensions.height15,
        ),
        child: Stack(
          children: [
            // body
            Positioned(
              top: Dimensions.height15,
              left: Dimensions.width30 * 2,
              right: 0,
              child: Container(
                height: (Dimensions.height50 / 2) * 4,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Dimensions.radius30 * 2),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: Dimensions.width70,
                ),
                child: Row(
                  children: [
                    // name, price, like ?
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppColors.textBlackColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // space
                          const Spacing(),
                          // price and like ?
                          Row(
                            children: [
                              // price
                              Container(
                                height: Dimensions.height20,
                                width: Dimensions.width52 + Dimensions.width10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius10,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/bg1.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: Dimensions.font10,
                                    ),
                                  ),
                                ),
                              ),
                              // space
                              const Spacing(),
                              // liked ?
                              if (fav)
                                Container(
                                height: Dimensions.height24,
                                width: Dimensions.width24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/like2.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // space
                    const Spacing(),
                    // cart
                    Container(
                      height: Dimensions.height39,
                      width: Dimensions.width39,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/cart2.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // space
                    Spacing(
                      width: Dimensions.width30,
                    ),
                  ],
                ),
              ),
            ),
            // image
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: Dimensions.height100 + Dimensions.height20,
                width: Dimensions.height100 + Dimensions.height20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: Dimensions.height100,
                    width: Dimensions.height100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor,
                      image: DecorationImage(
                        image: NetworkImage(product.images[0].src),
                        fit: BoxFit.fill,
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
