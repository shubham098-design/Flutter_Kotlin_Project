import 'dart:io';

import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/models/product_model.dart';
import 'package:r_goldsmith_shop_flutter/user/services/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/helper.dart';

class ProductController extends GetxController{
  var addProductLoading = false.obs;
  var addCategoryLoading = false.obs;
  var getProductsLoading = false.obs;
  Rx<File?> image1 = Rx<File?>(null);
  var products = <Product>[].obs; // Observable list of products

  @override
  void onInit() async{
    getProducts();
    super.onInit();
  }

  Future<void> addProduct(String name , String description , String category ,String price , String stock) async{
    try{
      var image_url = "";
      addProductLoading.value = true;

      if(image1.value != null && image1.value!.existsSync() ){
        var dir = "$category/$name";
        await SupabaseServices.supabaseClient.storage.from('bucket').upload(dir, image1.value!,fileOptions: const FileOptions(upsert: true));
        image_url = SupabaseServices.supabaseClient.storage
            .from('bucket')
            .getPublicUrl(dir);
      }
       await SupabaseServices.supabaseClient.from('product_table')
          .insert({'name':name,'description':description,'category':category,'price':price,'stock':stock,'first_image_url':image_url,}).then((value){
            addProductLoading.value = false;
            Get.snackbar("Success", "Product added successfully");
            Get.back();
       });

    } on StorageException catch(e) {
      addProductLoading.value = false;
      Get.snackbar("Error", e.message);
    } on AuthException catch(e) {
      addProductLoading.value = false;
      Get.snackbar("Error", e.message);
    } catch(e){
      addProductLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> addCategory(String name,String description) async{
    try{
      addCategoryLoading.value = true;
       await Supabase.instance.client.from('category_table')
          .insert({'name':name,'description':description}).then((value){
            addCategoryLoading.value = false;
            Get.snackbar("Success", "Category added successfully");
            Get.back();
       });
    } on AuthException catch(e) {
      addCategoryLoading.value = false;
      Get.snackbar("Error", e.message);
    }
  }

  void pickImage1() async{
    File? file = await pickImageFromGallery();
    if(file != null){
      image1.value = file;
    }
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
      Get.snackbar("Error", e.message);
      getProductsLoading.value = false;
    } on AuthException catch(e) {
      Get.snackbar("Error", e.message);
      getProductsLoading.value = false;
    } catch(e){
      Get.snackbar("Error", e.toString());
      getProductsLoading.value = false;
    }
  }

}