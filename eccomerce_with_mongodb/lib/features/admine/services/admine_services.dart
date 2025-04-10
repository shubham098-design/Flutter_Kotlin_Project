import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eccomerce_with_mongodb/constrants/error_handing.dart';
import 'package:eccomerce_with_mongodb/models/product.dart';
import 'package:eccomerce_with_mongodb/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constrants/global_variable.dart';
import '../../../constrants/utils.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {

    try{
      final cloudinary = CloudinaryPublic("drbca9lhu", "ml_default");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,folder: name),
        );
        imageUrls.add(cloudinaryResponse.secureUrl);

      }
      Product product = Product(name: name, description: description, quantity: quantity, images: imageUrls, category: category, price: price);

      http.Response res = await http.post(Uri.parse('$uri/api/addproduct',),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }
          , body: product.toJson()
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Product Added Successfully');
        Navigator.pop(context);
      });

    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

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


  Future<bool> deleteProduct(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse("$uri/api/products/$productId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return true; // Product successfully deleted
      } else {
        print("Failed to delete product: ${response.body}");
        return false; // Deletion failed
      }
    }catch (e) {
      print("Error deleting product: $e");
      return false; // Deletion failed
    }
  }


  Future<void> updateProduct(String productId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse("$uri/api/products/$productId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );
      if (response.statusCode == 200) {
        print("Product updated successfully: ${response.body}");
      } else {
        print("Failed to update product: ${response.body}");
      }
    } catch (error) {
      print("Error updating product: $error");
    }
  }


}
