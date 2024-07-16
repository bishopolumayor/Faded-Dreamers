import 'package:faded_dreamers/models/product_model.dart';
import 'package:faded_dreamers/screens/home/components/popular_recommended_products.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/small_product_container.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularRecommendedProducts extends StatefulWidget {
  final List<ProductModel> products;

  const PopularRecommendedProducts({
    super.key,
    required this.products,
  });

  @override
  State<PopularRecommendedProducts> createState() =>
      _PopularRecommendedProductsState();
}

class _PopularRecommendedProductsState
    extends State<PopularRecommendedProducts> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = widget.products;
    return Container(
      height: Dimensions.height100 + Dimensions.height30,
      width: double.maxFinite,
      color: AppColors.whiteColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return SmallProductContainer(
            product: product,
          );
        },
        itemCount: products.length,
      ),
    );
  }
}
