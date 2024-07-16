import 'package:faded_dreamers/controllers/products_controller.dart';
import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/screens/home/components/popular_recommended_products.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/big_products_container.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  ProductsController productsController = Get.find<ProductsController>();

  var searchController = TextEditingController();

  List<ProductModel> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    if(query.isNotEmpty){
      setState(() {
        filteredProducts = productsController.allProducts
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> recommendedProducts = productsController.hybridList;
    return Scaffold(
      backgroundColor: AppColors.lightBlueWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // space
            Spacing(
              height: Dimensions.height100,
            ),
            // back and search
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
                  // search
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                    },
                    child: Text(
                      'Search',
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
                    },
                    child: Container(
                      width: Dimensions.width20 + Dimensions.width5,
                      height: Dimensions.height20 + Dimensions.height5,
                      decoration: const BoxDecoration(
                        /* image: DecorationImage(
                        image: AssetImage(
                          'assets/images/search.png',
                        ),
                      ),*/
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height30,
            ),
            // main body
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius45),
                  topRight: Radius.circular(Dimensions.radius45),
                ),
              ),
              child: Column(
                children: [
                  // space
                  Spacing(
                    height: Dimensions.height30,
                  ),
                  // textField
                  Center(
                    child: Container(
                      // height: Dimensions.height52,
                      width: Dimensions.width30 * 10,
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColors.mainColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: const BorderSide(
                              color: AppColors.mainColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            borderSide: const BorderSide(
                              color: AppColors.mainColor,
                              width: 1.5,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.lightBlueWhite,
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: Dimensions.height24,
                                width: Dimensions.width24,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/search2.png'
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          color: AppColors.textBlackColor,
                          fontFamily: 'Inter',
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    ),
                  ),
                  // space
                  Spacing(
                    height: Dimensions.height30,
                  ),
                  // text
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.width30,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Suggested for you',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                            fontSize: Dimensions.font18,
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
                  // products
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height40,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        ProductModel product = filteredProducts[index];
                        return BigProductsContainer(
                          product: product,
                        );
                      },
                      itemCount: filteredProducts.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
