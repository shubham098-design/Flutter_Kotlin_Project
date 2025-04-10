import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:r_goldsmith_shop_flutter/admine/models/cartItems_model.dart';
import 'package:r_goldsmith_shop_flutter/user/services/shared_pref_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admine/models/cart_model.dart';
import '../../admine/models/product_model.dart';
import '../services/supabase_services.dart';

class CartController extends GetxController {
  var addToCartLoading = false.obs;
  var getCartLoading = false.obs;
  var cartList = <CartItemModel>[].obs;

  var cartProductsList = <Product>[].obs;
  var getProductByIdLoading = false.obs;
  var totalPrice = 0.obs;

  SharedPrefServices sharedPrefServices = SharedPrefServices();

  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  Future<void> addToCart(int productId, String quantity) async {
    try {
      addToCartLoading.value = true;
      await SupabaseServices.supabaseClient
          .from('cart_table')
          .insert({
            'user_id': sharedPrefServices.getUserId(),
            'product_id': productId,
            'quantity': quantity,
          })
          .then((value) async{
            addToCartLoading.value = false;
            Get.snackbar("Success", "Product added to cart successfully");
            await getCart();
          });
    } on StorageException catch (e) {
      addToCartLoading.value = false;
    } on AuthException catch (e) {
      addToCartLoading.value = false;
    } catch (e) {
      addToCartLoading.value = false;
    }
  }

  Future<void> getCart() async {
    try {
      getCartLoading.value = true;
      final response = await SupabaseServices.supabaseClient
          .from('cart_table')
          .select('product_id')
          .eq('user_id', sharedPrefServices.getUserId());
      if (response.isEmpty) {
        throw Exception("No cart found");
      }
      cartList.value = response.map((e) => CartItemModel.fromJson(e)).toList();

      getCartLoading.value = false;
    } on StorageException catch (e) {
      getCartLoading.value = false;
    } on AuthException catch (e) {
      getCartLoading.value = false;
    } catch (e) {
      getCartLoading.value = false;
    }
  }

  Future<void> fetchCartProducts(List<int> productIds) async {
    try {
      getProductByIdLoading.value = true;

      List<Product> fetchedProducts = [];
      var totalprice = 0;

      for (int id in productIds) {
        final response =
            await SupabaseServices.supabaseClient
                .from('product_table')
                .select()
                .eq('id', id)
                .single();

        fetchedProducts.add(Product.fromJson(response));
        totalprice += int.parse(response['price']);
      }
      cartProductsList.value = fetchedProducts;
      totalPrice.value = totalprice;
    } catch (e) {
      print("Error fetching product: $e");
    } finally {
      getProductByIdLoading.value = false;
    }
  }
  var removeCartLoading = false.obs;
  Future<void> removeFromCart(int productId) async {
    try {
      removeCartLoading.value = true;
      await SupabaseServices.supabaseClient
          .from('cart_table')
          .delete()
          .eq('user_id', sharedPrefServices.getUserId())
          .eq('product_id', productId)
          .then((value) {
          removeCartLoading.value = false;
            getCart();
            Get.snackbar("Success", "Product removed from cart successfully");
          });
    } on StorageException catch (e) {
      removeCartLoading.value = false;
    } on AuthException catch (e) {
      removeCartLoading.value = false;
    } catch (e) {
      removeCartLoading.value = false;
    }
  }

  var removeAllCartLoading = false.obs;
  Future<void> removeAllFromCart() async {
    try {
      removeAllCartLoading.value = true;
      await SupabaseServices.supabaseClient
          .from('cart_table')
          .delete()
          .eq('user_id', sharedPrefServices.getUserId())
          .then((value) {
            getCart();
            removeAllCartLoading.value = false;
            Get.snackbar("Success", "All products removed from cart successfully");
          });
    } on StorageException catch (e) {
      removeAllCartLoading.value = false;
    } on AuthException catch (e) {
      removeAllCartLoading.value = false;
    } catch (e) {
      removeAllCartLoading.value = false;
    }
  }


}
