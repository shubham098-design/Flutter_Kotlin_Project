import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../constrants/global_variable.dart';
import '../../../models/product_model.dart';

class SearchServices {

  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$uri/api/products/search/$query'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }


  
}