import 'package:dio/dio.dart';
import 'package:eccomerce_with_mongodb/features/auth/shared_pref/shared_prefs.dart';

import '../../../models/order.dart';

class OrderService {
  final Dio _dio = Dio();

  Future<List<Order>> fetchOrders() async {
    String? userId = await SharedPrefs.getUserId();
    try {
      final response = await _dio.get(
        "https://ecommerceamozonclone.vercel.app/api/orders/$userId",
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((order) => Order.fromJson(order))
            .toList();
      }
    } catch (e) {
      print("Error fetching orders: $e");
    }
    return [];
  }

  Future<void> placeOrder(
    List<Map<String, dynamic>> products,
    String amount,
    String street,
    String city,
    String pincode,
  ) async {
    String? userId = await SharedPrefs.getUserId();

    try {
      final response = await _dio.post(
        "https://ecommerceamozonclone.vercel.app/api/orders",
        data: {
          "userId":userId,
          "products": products,
          "amount": int.tryParse(amount) ?? 0,
          "address": {"street": street, "city": city, "pincode": pincode},
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print("Order Placed Successfully: ${response.data}");
    } on DioException catch (e) {
      if (e.response != null) {
        print(
          "Server Error: ${e.response?.statusCode} - ${e.response?.data}",
        );
      } else {
        print("Network Error: ${e.message}");
      }
    } catch (e) {
      print( "Unexpected Error: $e");
    }
  }
}
