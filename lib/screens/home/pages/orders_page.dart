import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  bool _isLoading = false;

  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();

    initializeOrders();
  }

  void initializeOrders() async {
    setState(() {
      _isLoading = true;
    });
    List<dynamic> ordersData = await productsController.getOrders();
    setState(() {
      orders = ordersData.reversed.toList();
      _isLoading = false;
    });
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    HapticFeedback.lightImpact();

    Fluttertoast.showToast(
      msg: "Copied",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: Dimensions.font18,
    );
  }

  void viewOrderDetails(var order) async {
    Get.toNamed(
      AppRoutes.getOrderDetails(),
      arguments: order,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          orders.isEmpty
              ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacing(
            height: Dimensions.height20 * 10,
          ),
          Icon(
            Icons.receipt_long,
            color: AppColors.mainColor,
            size: Dimensions.iconSize24 * 4,
          ),
          Spacing(
            height: Dimensions.height30,
          ),
          Center(
            child: Text('No Orders yet',
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: Dimensions.font23,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),),
          ),
        ],
      )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var order = orders[index];
                    // String status = order['status'];
                    // List<dynamic> products = order['line_items'];
                    List<dynamic> dataProducts = order['products'];
                    List<ProductModel> allProducts =
                        productsController.allProducts;

                    List<ProductModel> orderProducts = [];
                    if (allProducts.isNotEmpty) {
                      orderProducts = dataProducts
                          .map((productData) {
                            int productId = productData['product_id'];
                            return allProducts.firstWhere(
                                (product) => product.id == productId);
                          })
                          .where((product) => product != null)
                          .toList();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height10,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // space
                          Spacing(
                            height: Dimensions.height10,
                          ),
                          // id and status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // order id
                              Text(
                                '${order['order_id']}',
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontFamily: 'Inter',
                                  fontSize: Dimensions.font12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              /*// status
                              Text(
                                status,
                                style: TextStyle(
                                  color: status == 'completed'
                                      ? Colors.green
                                      : status == 'processing'
                                          ? Colors.blue
                                          : status == 'on-hold'
                                              ? Colors.yellow
                                              : status == 'cancelled'
                                                  ? Colors.red
                                                  : status == 'refunded'
                                                      ? Colors.purple
                                                      : status == 'failed'
                                                          ? Colors.red
                                                          : status == 'pending'
                                                              ? Colors.orange
                                                              : Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: Dimensions.font12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),*/
                            ],
                          ),
                          // space
                          Spacing(
                            height: Dimensions.height20,
                          ),
                          // products
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // var product = products[index];
                              ProductModel product = orderProducts[index];
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // image
                                      Container(
                                        height: Dimensions.height70,
                                        width: Dimensions.height70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              product.images.first.src,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // name etc
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // product name
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontFamily: 'Inter',
                                                fontSize: Dimensions.font12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            // space
                                            const Spacing(),
                                            // quantity
                                            Text(
                                              'X ${dataProducts[index]['quantity']}',
                                              style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontFamily: 'Inter',
                                                fontSize: Dimensions.font10,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            // space
                                            const Spacing(),
                                            /*// price
                                            Text(
                                              'Total : \$${product['total']}',
                                              style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontFamily: 'Inter',
                                                fontSize: Dimensions.font12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),*/
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // space
                                  Spacing(
                                    height: Dimensions.height5,
                                  ),
                                  // line
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                    ),
                                    height: 1.5,
                                    width: double.maxFinite,
                                    color: Colors.grey.shade400,
                                  ),
                                  // space
                                  Spacing(
                                    height: Dimensions.height15,
                                  ),
                                ],
                              );
                            },
                            itemCount: orderProducts.length,
                          ),
                          // space
                          Spacing(
                            height: Dimensions.height20,
                          ),
                          // copy
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                viewOrderDetails(order);
                                // copyToClipboard(order['payment_url']);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: AppColors.mainColor,
                                    size: Dimensions.iconSize16,
                                  ),
                                  const Spacing(),
                                  Text(
                                    'View order details',
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontFamily: 'Inter',
                                      fontSize: Dimensions.font12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: orders.length,
                ),
          if (_isLoading)
            Column(
              children: [
                Spacing(
                  height: Dimensions.height70,
                ),
                const LinearProgressIndicator(color: AppColors.mainColor,),
              ],
            ),
        ],
      ),
    );
  }
}
