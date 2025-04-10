import 'package:dio/dio.dart';
import 'package:eccomerce_with_mongodb/features/auth/shared_pref/shared_prefs.dart';

import '../../../models/cart.dart';

class CartServices {
  final Dio _dio = Dio();

  Future<CartResponse?> fetchCartData() async {
    String? userId = await SharedPrefs.getUserId();

    try {
      final response = await _dio.get(
        "https://ecommerceamozonclone.vercel.app/api/getCart?userId=$userId",
      );

      print("Response: --------------------------------------- $response");
      if (response.statusCode == 200) {
        return CartResponse.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return null;
  }

  Future<void> addToCart(String productId,) async {
    String? userId = await SharedPrefs.getUserId();
    try {
      final response = await _dio.post(
        "https://ecommerceamozonclone.vercel.app/api/addToCart", // ✅ Corrected URL
        data: {
          "productId": productId,
          "userId": userId,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print("Response Data: ${response.data}");
    } on DioException catch (e) {
      if (e.response != null) {
        print("Server Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Network Error: ${e.message}");
      }
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }

  Future<void> removeFromCart(String productId) async {
    String? userId = await SharedPrefs.getUserId();
    try {
      final response = await _dio.delete(
        "https://ecommerceamozonclone.vercel.app/api/cart/$userId/$productId",
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print("Product Removed: ${response.data}");
    } on DioException catch (e) {
      if (e.response != null) {
        print(" Server Error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print(" Network Error: ${e.message}");
      }
    } catch (e) {
      print(" Unexpected Error: $e");
    }
  }


}
