import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admine/models/product_model.dart';
import '../services/supabase_services.dart';

class UserProductController extends GetxController{
  var getProductsLoading = false.obs;
  var getProductByIdLoading = false.obs;
  var getEaringLoading = false.obs;
  var getBracletLoading = false.obs;
  var getNecklaceLoading = false.obs;

  Rx<File?> image1 = Rx<File?>(null);

  var products = <Product>[].obs; // Observable list of products
  var productsInDescOrder = <Product>[].obs;
  var getEaringList = <Product>[].obs;
  var getBracletList = <Product>[].obs;
  var getNecklaceList = <Product>[].obs;

  var selectedProduct = Rxn<Product>();

  @override
  void onInit() async{
    getProducts();
    super.onInit();
  }

  Future<void> getProducts() async{
    try{
      getProductsLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select();
      if(response.isEmpty){
        throw Exception("No products found");
      }
      List<Product> fetchedProducts = response.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();
      products.assignAll(fetchedProducts);
      getProductsLoading.value = false;

    } on StorageException catch(e) {
      getProductsLoading.value = false;
    } on AuthException catch(e) {
      getProductsLoading.value = false;
    } catch(e){
      getProductsLoading.value = false;
    }
  }

  Future<void> getProductById(int id) async{
    try{
      getProductByIdLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select().eq('id',id).single();
      if(response.isEmpty){
        throw Exception("No products found");
      }
      selectedProduct.value = Product.fromJson(response);
      getProductByIdLoading.value = false;
    } on StorageException catch(e) {
      getProductByIdLoading.value = false;
    } on AuthException catch(e) {
      getProductByIdLoading.value = false;
    } catch(e){
      getProductByIdLoading.value = false;
    }
  }

  Future<void> getProductsByDescOrder() async{
    try{
      getProductsLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select().order('price::float8',ascending: false);
      if(response.isEmpty){
        throw Exception("No products found");
      }

      List<Product> fetchedProducts = response.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();

      productsInDescOrder.assignAll(fetchedProducts);
      getProductsLoading.value = false;
    } on StorageException catch(e) {
      getProductsLoading.value = false;
    } on AuthException catch(e) {
      getProductsLoading.value = false;
    } catch(e){
      getProductsLoading.value = false;
    }
  }

  Future<void> getEaringCategory() async{
    try{
      getEaringLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select().eq('category', 'earing');
      if(response.isEmpty){
        throw Exception("No products found");
      }
      List<Product> fetchedProducts = response.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();
      getEaringList.assignAll(fetchedProducts);
      getEaringLoading.value = false;

    } on StorageException catch(e) {
      getEaringLoading.value = false;
    } on AuthException catch(e) {
      getEaringLoading.value = false;
    } catch(e){
      getEaringLoading.value = false;
    }
  }

  Future<void> getBracletCategory() async{
    try{
      getBracletLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select().eq('category', 'braclet');
      if(response.isEmpty){
        throw Exception("No products found");
      }
      List<Product> fetchedProducts = response.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();
      getBracletList.assignAll(fetchedProducts);
      getBracletLoading.value = false;

    } on StorageException catch(e) {
      getBracletLoading.value = false;
    } on AuthException catch(e) {
      getBracletLoading.value = false;
    } catch(e){
      getBracletLoading.value = false;
    }
  }

  Future<void> getNecklaceCategory() async{
    try{
      getNecklaceLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('product_table').select().eq('category', 'braclet');
      if(response.isEmpty){
        throw Exception("No products found");
      }
      List<Product> fetchedProducts = response.map<Product>((json) {
        return Product.fromJson(json);
      }).toList();
      getBracletList.assignAll(fetchedProducts);
      getNecklaceLoading.value = false;

    } on StorageException catch(e) {
      getNecklaceLoading.value = false;
    } on AuthException catch(e) {
      getNecklaceLoading.value = false;
    } catch(e){
      getNecklaceLoading.value = false;
    }
  }


  var searchProduct = [].obs;
  var isLoading = false.obs;

  final SupabaseServices supabaseService = SupabaseServices();

  void search(String query) async {
    isLoading.value = true;
    try {
      var results = await supabaseService.searchProducts(query);
      searchProduct.value = results;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    isLoading.value = false;
  }
}