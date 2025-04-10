import 'package:eccomerce_with_mongodb/features/cart/services/cart_services.dart';
import 'package:flutter/material.dart';
import '../../../models/cart.dart';

class CartProvider with ChangeNotifier {
  CartResponse? cartResponse;
  bool isLoading = false;
  bool isAddingToCart = false;
  bool isRemovingFromCart = false;


  Future<void> fetchCart() async {
    isLoading = true;
    notifyListeners();

    cartResponse = await CartServices().fetchCartData();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addToCart(String productId) async {
    isAddingToCart = true;
    notifyListeners();
    await CartServices().addToCart(productId);
    isAddingToCart = false;
    notifyListeners();
  }

  Future<void> removeFromCart(String productId, String userId) async {
    isRemovingFromCart = true;
    notifyListeners();
    await CartServices().removeFromCart(productId);
    isRemovingFromCart = false;
    notifyListeners();
  }

}
