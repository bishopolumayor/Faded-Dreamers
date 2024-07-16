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

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductsController productsController = Get.find<ProductsController>();

  final PageController _pageController = PageController();

  double _currentPage = 0;

  List<ProductModel> recommendedProducts = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeProductDetails();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  void initializeProductDetails() async {
    List<ProductModel> allProducts = productsController.allProducts;
    ProductModel product = widget.product;

    List<ProductModel> tempRecommendedProducts = allProducts.where((prod) {
      return product.relatedIds.contains(prod.id);
    }).toList();

    setState(() {
      recommendedProducts = tempRecommendedProducts;
    });
  }

  void toggleLike() async {
    ProductModel product = widget.product;
    setState(() {
      _isLoading = true;
    });
    await productsController.toggleLikeProduct(productModel: product,);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void addToCart() async {
    ProductModel product = widget.product;
    // await productsController.addToCart(
    //   product: product,
    //   quantity: 1,
    // );
    Get.toNamed(AppRoutes.getProductOrderScreen(), arguments: product,);
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product = widget.product;
    bool fav = productsController.isFavorite(product.id);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            if(_isLoading)
              const LinearProgressIndicator(
                color: AppColors.mainColor,
              ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // pageView
            SizedBox(
              height: Dimensions.screenWidth,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              product.images[index].src,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: product.images.length,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: Dimensions.height20,
                      ),
                      height: Dimensions.height15,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            int page = _currentPage.toInt();
                            int lastPage = product.images.length - 1;
                            Color dotColor;

                            if (page < 1 && index == 0) {
                              dotColor = AppColors.mainColor;
                            } else if (page == lastPage && index == 2) {
                              dotColor = AppColors.mainColor;
                            } else if (page >= 1 &&
                                page < lastPage &&
                                index == 1) {
                              dotColor = AppColors.mainColor;
                            } else {
                              dotColor = AppColors.greyColor1;
                            }

                            return Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.width5 / 2,
                              ),
                              height: Dimensions.height28 / 2,
                              width: Dimensions.height28 / 2,
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                          itemCount: product.images.length > 3
                              ? 3
                              : product.images.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // name and price and add to cart
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width30,
              ),
              child: Column(
                children: [
                  // name ...
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            color: AppColors.textBlackColor,
                            fontSize: Dimensions.font20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // spacing
                      Spacing(
                        width: Dimensions.width30,
                      ),
                      // like ... dislike
                      GestureDetector(
                        onTap: (){
                          HapticFeedback.lightImpact();
                          toggleLike();
                          setState(() {
                            fav = !fav;
                          });
                        },
                        child: Container(
                          height: Dimensions.height30,
                          width: Dimensions.width30,
                          child: Center(
                            child: Icon(
                              fav ? Icons.favorite : Icons.favorite_outline,
                              size: Dimensions.iconSize24,
                              color: AppColors.redColor,
                            ),
                          ),
                        ),
                      ),
                      // spacing
                      Spacing(
                        width: Dimensions.width30,
                      ),
                    ],
                  ),
                  // space
                  Spacing(
                    height: Dimensions.height20,
                  ),
                  // price and add to cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                            '\$ ${product.price}',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: Dimensions.font14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      // add to cart
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          addToCart();
                        },
                        child: Container(
                          height: Dimensions.height30,
                          padding: EdgeInsets.symmetric(
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
                          child: Row(
                            children: [
                              // add to cart
                              Text(
                                'Order Product',
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: Dimensions.font14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // spacing
                              const Spacing(),
                              // white line
                              Container(
                                height: double.maxFinite,
                                width: 1,
                                color: AppColors.whiteColor,
                              ),
                              // space
                              const Spacing(),
                              // cart
                              Container(
                                height: Dimensions.height28,
                                width: Dimensions.width28,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/cart.png',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // description
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width20,
                top: Dimensions.height30,
                bottom: Dimensions.height20,
              ),
              width: double.maxFinite,
              color: AppColors.lightBlueWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // description
                  Text(
                    'Description: ',
                    style: TextStyle(
                      color: AppColors.textBlackColor,
                      fontSize: Dimensions.font20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // space
                  const Spacing(),
                  // text
                  Text(
                    product.description,
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: Dimensions.font14,
                    ),
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height20,
            ),
            // text
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width30,
              ),
              child: Row(
                children: [
                  Text(
                    'Products you may like',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      fontSize: Dimensions.font16,
                    ),
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height15,
            ),
            // popular
            PopularRecommendedProducts(
              products: recommendedProducts,
            ),
          ],
        ),
      ),
    );
  }
}
