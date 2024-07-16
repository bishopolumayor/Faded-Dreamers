import 'package:faded_dreamers/models/product_model.dart';

class CartModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final Map<String, dynamic> variation;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.variation,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      variation: json['variation'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'variation': variation,
    };
  }
}
