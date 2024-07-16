import 'package:faded_dreamers/controllers/auth_controller.dart';
import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/controllers/user_controller.dart';
import 'package:faded_dreamers/models/cart_model.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/screens/home/components/popular_recommended_products.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/screens/home/components/home_banner.dart';
import 'package:faded_dreamers/widgets/bar_loading_animation.dart';
import 'package:faded_dreamers/widgets/big_products_container.dart';
import 'package:faded_dreamers/widgets/cart_item_container.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
   final Map<String, dynamic>  order;
   const OrderDetailsScreen({super.key, required this.order,});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  ProductsController productsController = Get.find<ProductsController>();

  bool _isLoading = false;

  Map<String, dynamic>? orderDetails = null;

  @override
  void initState() {
    super.initState();
    initializeOrderDetails();
  }

  void initializeOrderDetails() async {
    String orderId = widget.order['order_id'];
    print(orderId);
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic>? orderData = await productsController.getOrderDetails(orderId);
    if (orderData != null){
      print(orderData);
      setState(() {
        orderDetails = orderData;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String dayOfWeek = DateFormat('EEE').format(dateTime);
    String dayOfMonth = DateFormat('d').format(dateTime);
    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);
    String time = DateFormat('h:mm a').format(dateTime);

    String daySuffix;
    if (dayOfMonth.endsWith('1') && dayOfMonth != '11') {
      daySuffix = 'st';
    } else if (dayOfMonth.endsWith('2') && dayOfMonth != '12') {
      daySuffix = 'nd';
    } else if (dayOfMonth.endsWith('3') && dayOfMonth != '13') {
      daySuffix = 'rd';
    } else {
      daySuffix = 'th';
    }

    return '$dayOfWeek $dayOfMonth$daySuffix $month $year $time';
  }

  @override
  Widget build(BuildContext context) {
    String orderId = widget.order['order_id'];
    List<dynamic> dataProducts = widget.order['products'];

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

    double totalPaid = orderDetails != null ? orderDetails!['net_amounts']['total_money']['amount'] / 100  : 0;
    String status = orderDetails != null ? orderDetails!['state'] : '';
    String ref = orderDetails != null ? orderDetails!['reference_id'] : '';
    String createdDate = orderDetails != null ? formatDateTime(orderDetails!['created_at']) : '';
    String updatedDate = orderDetails != null ? formatDateTime(orderDetails!['updated_at']) : '';

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              child: Column(
                children: [
                  Spacing(
                    height: Dimensions.height70,
                  ),
                  // back, favorites
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Get.back();
                        },
                        child: Container(
                          width: Dimensions.width30,
                          height: Dimensions.height22,
                          decoration: const BoxDecoration(
                            /* image: DecorationImage(
                            image: AssetImage(
                              'assets/images/back2.png',
                            ),
                          ),*/
                          ),
                          child: Icon(Icons.arrow_back, color: AppColors.mainColor, size: Dimensions.iconSize24,),
                        ),
                      ),
                      // favorites
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: Text(
                          'Order Details',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: Dimensions.font18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // empty
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        },
                        child: SizedBox(
                          width: Dimensions.width30,
                          height: Dimensions.height22,
                        ),
                      ),
                    ],
                  ),
                  if(_isLoading)
                    const LinearProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  // space
                  Spacing(
                    height: Dimensions.height50,
                  ),
                  // products
                  if(orderDetails != null && orderDetails!['net_amounts']['total_money']['amount'] != null )
                    Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // var product = products[index];
                            ProductModel product = orderProducts[index];
                            var lineItems = orderDetails!['line_items'];
                            double basePrice = lineItems[index]['base_price_money']['amount'] / 100 ;
                            double totalPrice = lineItems[index]['total_money']['amount'] / 100 ;

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
                                            '\$$basePrice X ${dataProducts[index]['quantity']}',
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: 'Inter',
                                              fontSize: Dimensions.font10,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          // space
                                          const Spacing(),
                                          // price
                                          Text(
                                            'Subtotal : \$$totalPrice',
                                            style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontFamily: 'Inter',
                                              fontSize: Dimensions.font12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
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
                        // total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // space
                            Spacing(
                              width: Dimensions.height20,
                            ),
                            // space
                            Spacing(
                              width: Dimensions.height20,
                            ),
                            // amount
                            Text(
                              '\$$totalPaid',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height20,
                        ),
                        // status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // status
                            Text(
                              status,
                              style: TextStyle(
                                color: status == 'COMPLETED' ? Colors.green : Colors.yellow,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height10,
                        ),
                        // orderId
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order ID',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // status
                            Text(
                              orderId,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height10,
                        ),
                        // created
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Created',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // created
                            Text(
                              createdDate,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height10,
                        ),
                        // updated
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Updated',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // updated
                            Text(
                              updatedDate,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        // space
                        Spacing(
                          height: Dimensions.height10,
                        ),
                        // ref
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reference',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            // ref
                            Text(
                              ref,
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Dimensions.font14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  // space
                  Spacing(
                    height: Dimensions.height20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
