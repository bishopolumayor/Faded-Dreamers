import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/routes/routes.dart';
import 'package:faded_dreamers/screens/home/components/popular_recommended_products.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductOrderScreen extends StatefulWidget {
  final ProductModel product;

  const ProductOrderScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductOrderScreen> createState() => _ProductOrderScreenState();
}

class _ProductOrderScreenState extends State<ProductOrderScreen> {
  ProductsController productsController = Get.find<ProductsController>();

  int quantity = 1;

  bool _isLoading = false;

  List<Map<String, dynamic>> variations = [];

  Map<String, dynamic>? selectedVariation;

  @override
  void initState() {
    super.initState();
    initializeProduct();
  }

  void initializeProduct() async {
    setState(() {
      _isLoading = true;
    });
    ProductModel product = widget.product;
    List<Map<String, dynamic>>? productsVariations = (await productsController.getProductVariations(product))?.cast<Map<String, dynamic>>();
    if (productsVariations != null) {
      setState(() {
        variations = productsVariations.reversed.toList();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void addToCart() async {
    ProductModel product = widget.product;
    if(selectedVariation != null){
      await productsController.addToCart(
        product: product,
        quantity: quantity,
        variation: selectedVariation!,
      );
    } else {
      Get.snackbar('Error', 'Select a variation', colorText: AppColors.whiteColor, backgroundColor: AppColors.redColor,);
    }
  }

  void increaseQuantity() {
    HapticFeedback.lightImpact();
    if(quantity < 20){
      setState(() {
        quantity++;
      });
    }
  }

  void decreaseQuantity(){
    HapticFeedback.lightImpact();
    if (quantity > 1){
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.product;
    return Scaffold(
      body: Column(
        children: [
          // space
          Spacing(
            height: Dimensions.height70,
          ),
          // back and pluto
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Row(
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
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/back2.png',
                        ),
                      ),
                    ),
                  ),
                ),
                // profile
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                  },
                  child: Text(
                    'Pluto',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // search
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.toNamed(AppRoutes.getSearchProductsScreen());
                  },
                  child: Container(
                    width: Dimensions.width20 + Dimensions.width5,
                    height: Dimensions.height20 + Dimensions.height5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/search.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // loading
          if (_isLoading)
            const LinearProgressIndicator(
              color: AppColors.mainColor,
            ),
          // space
          Spacing(
            height: Dimensions.height20,
          ),
          // product
          Container(
            height: Dimensions.height150 + Dimensions.height5,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10,
            ),
            child: Row(
              children: [
                // image
                Container(
                  height: Dimensions.height150 + Dimensions.height5,
                  width: Dimensions.width100 + Dimensions.width24,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.images[0].src),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                ),
                // space
                Spacing(
                  width: Dimensions.width15,
                ),
                // other details
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
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                    // space
                    Spacing(
                      height: Dimensions.height10,
                    ),
                    // cat
                    Text(
                      product.categories[0].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.font16,
                      ),
                    ),
                    // space
                    Spacing(
                      height: Dimensions.height10,
                    ),
                    // variation and quantity
                    SizedBox(
                      height: Dimensions.height40,
                      child: Row(
                        children: [
                          // variation
                          Expanded(
                            child: DropdownButtonFormField<Map<String, dynamic>>(
                              value: selectedVariation,
                              onChanged: (Map<String, dynamic>? newValue) {
                                setState(() {
                                  selectedVariation = newValue!;
                                });
                              },
                              items: variations.map<DropdownMenuItem<Map<String, dynamic>>>(
                                    (Map<String, dynamic> variation) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: variation,
                                    child: Text(
                                      variation['name'],
                                      style: TextStyle(
                                        fontSize: Dimensions.font14,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width5,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'Variation',
                                hintStyle: TextStyle(
                                  fontSize: Dimensions.font14,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: Dimensions.iconSize16,
                              ),
                            ),
                          ),
                          // space
                          Spacing(
                            width: Dimensions.width10,
                          ),
                          // quantity
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade200,
                              child: Row(
                                children: [
                                  // decrease quantity
                                  Expanded(
                                    child: GestureDetector(
                                    onTap: () {
                                      decreaseQuantity();
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      padding : EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                      ),
                                      child: Icon(Icons.remove, size: Dimensions.iconSize16,),
                                    ),
                                  ),
                                  ),
                                  // quantity
                                  Center(
                                    child: Text(
                                      'Qty $quantity',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: Dimensions.font14,
                                      ),
                                    ),
                                  ),
                                  // increase quantity
                                  Expanded(
                                    child: GestureDetector(
                                    onTap: (){
                                      increaseQuantity();
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      padding : EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                      ),
                                      child: Icon(Icons.add, size: Dimensions.iconSize16,),
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // space
                    Spacing(
                      height: Dimensions.height10,
                    ),
                    // to be delivered in
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'To be Delivered in ',
                            style: TextStyle(
                              color: AppColors.textBlackColor,
                              fontFamily: 'Inter',
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w300,
                            )
                          ),
                          TextSpan(
                            text: 'XX days time',
                            style: TextStyle(
                              color: AppColors.textBlackColor,
                              fontFamily: 'Inter',
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.w500,
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // coupon
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: GestureDetector(
              onTap: (){
                Get.snackbar('Not available', '😞 No coupons available at this time, check back later',);
              },
              child: Row(
                children: [
                  // coupon image
                  Container(
                    height: Dimensions.height20,
                    width: Dimensions.width30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/coupon.png',
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    width: Dimensions.width20,
                  ),
                  // apply coupons
                  Text(
                    'Apply Coupons',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlackColor,
                      fontSize: Dimensions.font18,
                      fontFamily: 'Inter',
                    ),
                  ),
                  // space
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // select
                  Text(
                    'Select',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font16,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // line
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            height: 1,
            color: Colors.grey,
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // order details
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // order payment details
                Text(
                  'Order Payment Details',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textBlackColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.font18,
                  ),
                ),
                // space
                Spacing(
                  height: Dimensions.height30,
                ),
                // amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // order amount
                    Text(
                      'Order Amounts',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                    // amount
                    Text(
                      selectedVariation == null 
                          ? '\$${(double.parse(product.price)).toStringAsFixed(2)} X $quantity'
                          : '\$${(double.parse(selectedVariation!['price'])).toStringAsFixed(2)} X $quantity',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                  ],
                ),
                // space
                Spacing(
                  height: Dimensions.height20,
                ),
                // convenience
                Row(
                  children: [
                    // convenience
                    Text(
                      'Convenience',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                    // space
                    Spacing(
                      width: Dimensions.width20,
                    ),
                    // know more
                    Text(
                      'Know more',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font16,
                      ),
                    ),
                    // space
                    const Expanded(
                      child: SizedBox(),
                    ),
                    // apply coupon
                    Text(
                      'Apply coupon',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font16,
                      ),
                    ),
                  ],
                ),
                // space
                Spacing(
                  height: Dimensions.height20,
                ),
                // delivery fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // delivery fee
                    Text(
                      'Delivery Fee',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                    // free
                    Text(
                      'Free',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // line
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            height: 1,
            color: Colors.grey,
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // order total
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // order total
                    Text(
                      'Order Total',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                    // amount
                    Text(
                      selectedVariation == null
                          ? '\$${(double.parse(product.price) * quantity).toStringAsFixed(2)}'
                          : '\$${(double.parse(selectedVariation!['price']) * quantity).toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textBlackColor,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // line
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimensions.width20,
            ),
            height: 1,
            color: Colors.grey,
          ),
          // space
          Spacing(
            height: Dimensions.height50,
          ),
          // add to cart
          Center(
            child: GestureDetector(
              onTap: (){
                addToCart();
              },
              child: Container(
                width: Dimensions.width20 * 10,
                height: Dimensions.height50 ,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                child: Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.font18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
