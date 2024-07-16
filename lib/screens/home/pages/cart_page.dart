import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/cart_model.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:faded_dreamers/widgets/cart_item_container.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  double processingFeePercentage = 0;

  bool  _isLoading = false;

  double calculateSubtotal(List<CartModel> cart) {
    double subtotal = 0.0;
    for (var item in cart) {
      double price = double.tryParse(item.variation['price']) ?? 0.0;
      subtotal += price * item.quantity;
    }
    return subtotal;
  }

  double calculateProcessingFees(double subtotal) {
    return subtotal * (processingFeePercentage / 100);
  }

  String formatToDollarAmount(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(amount);
  }

  void checkOut() async {
    setState(() {
      _isLoading = true;
    });
    await productsController.checkoutCart();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // space
              Spacing(
                height: Dimensions.height70,
              ),
              // cart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // cart
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                    child: Text(
                      'Cart',
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
                height: Dimensions.height20,
              ),
              // cart items
              Obx(() {
                List<CartModel> cart = productsController.cart;
                double subtotal = calculateSubtotal(cart);
                double processingFees = calculateProcessingFees(subtotal);
                double total = subtotal + processingFees;

                if(cart.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacing(
                        height: Dimensions.height20 * 10,
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSize24 * 4,
                      ),
                      Spacing(
                        height: Dimensions.height30,
                      ),
                      Center(
                        child: Text('Empty Cart',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: Dimensions.font23,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal : Dimensions.width5,
                        ),
                        child: Wrap(
                          spacing: Dimensions.width10,
                          runSpacing: Dimensions.height20,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: cart.map((cartItem) => CartItemContainer(cartModel: cartItem)).toList().reversed.toList(),
                        ),
                      ),
                      // space
                      Spacing(
                        height: Dimensions.height50,
                      ),
                      // subtotal
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              formatToDollarAmount(subtotal),
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // space
                      Spacing(
                        height: Dimensions.height20,
                      ),
                      // processing fees
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Processing Fees',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              formatToDollarAmount(processingFees),
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: Dimensions.font16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // space
                      Spacing(
                        height: Dimensions.height20,
                      ),
                      // total
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              formatToDollarAmount(total),
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // space
                      Spacing(
                        height: Dimensions.height50,
                      ),
                      // go to checkout
                      GestureDetector(
                        onTap: (){
                          HapticFeedback.lightImpact();
                          checkOut();
                        },
                        child: Container(
                          height: Dimensions.height40,
                          width: Dimensions.width22 * 10,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/bg1.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Go to Checkout',
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.font16
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
              // space
              Spacing(
                height: Dimensions.height20,
              ),
            ],
          ),
        ),
        if(_isLoading)
          const Center(
            child: BarLoadingAnimation(),
          ),
      ],
    );
  }
}
