import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/cart_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admine/models/order_model.dart';
import '../../admine/models/product_model.dart';
import '../services/shared_pref_services.dart';
import '../services/supabase_services.dart';

class OrderController extends GetxController{
  RxBool sendOrderLoading = false.obs;

  var getOrders = <OrderModel>[].obs;
  var getOrderLoading = false.obs;

  var orderProductsList = <Product>[].obs;
  var getProductByIdLoading = false.obs;

  SharedPrefServices sharedPrefServices = SharedPrefServices();

  CartController cartController = Get.put(CartController());

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> sendOrder(int productId,String quantity,String totalPrice,String address,String phone,String paymentMethod,) async{
    try{
      sendOrderLoading.value = true;
      await SupabaseServices.supabaseClient.from('order_table').insert({
        'user_id':sharedPrefServices.getUserId(),
        'product_id':productId,
        'quantity':quantity,
        'total_price':totalPrice,
        'address':address,
        'phone':phone,
        'payment_method':paymentMethod,
      }).then((value){
        getOrdersbyUser();
        sendOrderLoading.value = false;
        Get.snackbar("Success", "Order placed successfully");
        cartController.getCart();
      });
    } on StorageException catch(e) {
      sendOrderLoading.value = false;
    } on AuthException catch(e) {
      sendOrderLoading.value = false;
    } catch(e){
      sendOrderLoading.value = false;
    }
  }

  Future<void> sendMultipleOrders(List<Map<String, dynamic>> orders) async {
    try {
      sendOrderLoading.value = true;

      await SupabaseServices.supabaseClient.from('order_table').insert(orders).then((value){
        getOrdersbyUser();
        sendOrderLoading.value = false;
        Get.snackbar("Success", "Orders placed successfully");
        cartController.getCart();
      });

    } on StorageException catch (e) {
      sendOrderLoading.value = false;
    } on AuthException catch (e) {
      sendOrderLoading.value = false;
    } catch (e) {
      sendOrderLoading.value = false;
    }
  }



  Future<void> getOrdersbyUser() async{
    try{
      getOrderLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('order_table')
          .select('product_id').eq('user_id',sharedPrefServices.getUserId()).order('created_at',ascending: false);
      if(response.isEmpty){
        throw Exception("No orders found");
      }
      getOrders.value = response.map((e) => OrderModel.fromJson(e)).toList();
      getOrderLoading.value = false;
    } on StorageException catch(e) {
      getOrderLoading.value = false;
    } on AuthException catch(e) {
      getOrderLoading.value = false;
    } catch(e){
      getOrderLoading.value = false;
    }
  }



  Future<void> fetchOrderProducts(List<int> productIds) async {
    try {
      getProductByIdLoading.value = true;

      List<Product> fetchedProducts = [];

      for (int id in productIds) {
        final response =
        await SupabaseServices.supabaseClient
            .from('product_table')
            .select()
            .eq('id', id)
            .single();

        fetchedProducts.add(Product.fromJson(response));
      }
      orderProductsList.value = fetchedProducts;
    } catch (e) {
      print("Error fetching product: $e");
    } finally {
      getProductByIdLoading.value = false;
    }
  }
}