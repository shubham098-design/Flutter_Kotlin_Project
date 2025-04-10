import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constrants/global_variable.dart';
import '../../../models/product_model.dart';

class HomeService {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$uri/api/products'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/products/category/$category'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
