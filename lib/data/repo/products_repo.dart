import 'dart:convert';

import 'package:faded_dreamers/data/api/api_client.dart';
import 'package:faded_dreamers/models/cart_model.dart';
import 'package:faded_dreamers/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProductsRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getProducts() async {
    return await apiClient.getData(AppConstants.PRODUCTS_URI);
  }

  Future<Response> getProductVariations(int productId) async {
    return await apiClient.getData('${AppConstants.PRODUCTS_URI}/$productId/variations');
  }

  Future<Response> getFavoriteProducts(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.FAVORITE_PRODUCTS_URI, data);
  }

  Future <Response> toggleLikeProduct(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.TOGGLE_FAVORITE_URI, data);
  }

  Future<void> saveCart(List<CartModel> cart) async {
    String cartJson = jsonEncode(cart.map((item) => item.toJson()).toList());
    await sharedPreferences.setString(AppConstants.CART_KEY, cartJson);
  }

  List<CartModel> getCart() {
    String? cartJson = sharedPreferences.getString(AppConstants.CART_KEY);
    if (cartJson != null) {
      List<dynamic> cartList = jsonDecode(cartJson);
      return cartList.map((item) => CartModel.fromJson(item)).toList();
    }
    return [];
  }
  
  Future<Response> checkout(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.ORDER_URI, data);
  }

  Future<Response> createOrder(Map<String, dynamic> data) async {
    return await apiClient.postData(AppConstants.CREATE_ORDER_URI, data);
  }

  Future<Response> getOrders(int userId) async {
    return await apiClient.getData('${AppConstants.ORDER_URI}?user_id=$userId');
  }

  Future<Response> getWCOrders(int userId) async {
    return await apiClient.getData('${AppConstants.WCORDER_URI}?customer=$userId');
  }
}
