import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/models/cart_model.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CartItemContainer extends StatefulWidget {
  final CartModel cartModel;

  const CartItemContainer({
    super.key,
    required this.cartModel,
  });

  @override
  State<CartItemContainer> createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  ProductsController productsController = Get.find<ProductsController>();

  void increaseQuantity() async {
    CartModel cartModel = widget.cartModel;
    await productsController.increaseQuantity(cartModel.id);
  }

  void decreaseQuantity() async {
    CartModel cartModel = widget.cartModel;
    await productsController.decreaseQuantity(cartModel.id);
  }

  void removeFromCart() async {
    CartModel cartModel = widget.cartModel;
    await productsController.removeFromCart(cartModel.id);
  }

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = widget.cartModel;
    ProductModel product = cartModel.product;
    Map<String, dynamic> variation = cartModel.variation;
    return Container(
      // height: (Dimensions.height22) * 10,
      width: Dimensions.width140 + Dimensions.width50 + Dimensions.width10 ,
      padding: EdgeInsets.only(
        bottom: Dimensions.height15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
          ),
        ],
        borderRadius:
            BorderRadius.circular(Dimensions.radius10 + Dimensions.radius15),
      ),
      child: Column(
        children: [
          // image
          GestureDetector(
            onTap: (){
              HapticFeedback.lightImpact();
              Get.toNamed(
                AppRoutes.getProductDetailScreen(),
                arguments: product,
              );
            },
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height100 + Dimensions.height50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    Dimensions.radius10 + Dimensions.radius15),
                image: DecorationImage(
                  image: NetworkImage(product.images.first.src),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // space
          const Spacing(),
          // name and price
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10,
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // name and variation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name
                    Text(
                        product.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: Dimensions.font12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // space
                    Spacing(
                      height: Dimensions.height5,
                    ),
                    // variation
                    Text(
                        variation['name'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: Dimensions.font18 / 2,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // space
              const Spacing(),
              // price
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height5 / 2,
                  horizontal: Dimensions.width5,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius5),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/bg1.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    '\$${variation['price']}',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: Dimensions.font12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
          // space
          const Spacing(),
          // increase, decrease, delete
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // - , x 2 , +
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // -
                    GestureDetector(
                      onTap:(){
                        HapticFeedback.lightImpact();
                        decreaseQuantity();
                      },
                      child: Container(
                        height: Dimensions.height30,
                        width: Dimensions.width50 / 1.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius10),
                            bottomLeft: Radius.circular(Dimensions.radius10),
                          ),
                        ),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: AppColors.mainColor,
                              size: Dimensions.iconSize16,
                            ),
                          ),
                      ),
                    ),
                    // x quantity
                    Container(
                      height: Dimensions.height30,
                      width: Dimensions.width40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' x ${cartModel.quantity} ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimensions.font10,
                                color: AppColors.mainColor
                            ),
                          ),
                          Spacing(
                            height: Dimensions.screenHeight / 932,
                          ),
                        ],
                      ),
                    ),
                    // +
                    GestureDetector(
                      onTap:(){
                        HapticFeedback.lightImpact();
                        increaseQuantity();
                      },
                      child: Container(
                        height: Dimensions.height30,
                        width: Dimensions.width50 / 1.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius10),
                            bottomRight: Radius.circular(Dimensions.radius10),
                          ),
                        ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: AppColors.mainColor,
                              size: Dimensions.iconSize16,
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                // delete
                GestureDetector(
                  onTap: (){
                    HapticFeedback.lightImpact();
                    removeFromCart();
                  },
                  child: Container(
                    height: Dimensions.height30,
                    width: Dimensions.width30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/delete.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
