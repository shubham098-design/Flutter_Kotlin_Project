import 'package:eccomerce_with_mongodb/features/order/services/order_services.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/order.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _apiService = OrderService();
  List<Order> _orders = [];
  bool _isLoading = false;
  bool isPlacedOrderLoading = false;

  List<Order> get orders => _orders;

  bool get isLoading => _isLoading;

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();
    _orders = await _apiService.fetchOrders();
    _isLoading = false;
    notifyListeners();
  }


  Future<void> placeOrder(
      String userId,
      List<Map<String, dynamic>> products,
      String amount,
      String street,
      String city,
      String pincode,
      ) async {
    isPlacedOrderLoading = true;
    notifyListeners();
    await _apiService.placeOrder(products, amount, street, city, pincode);
    isPlacedOrderLoading = false;
    notifyListeners();

  }


}
