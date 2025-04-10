import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:r_goldsmith_shop_flutter/admine/controller/product_controller.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/cart_controller.dart';

import '../controller/order_controller.dart';
import '../route/routes.dart';
import '../widget/CartItems.dart';
import '../widget/orderItems.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  OrderController orderController = Get.put(OrderController());
  ProductController productController = Get.put(ProductController());
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    getProductsFromOrders();
  }

  void getProductsFromOrders() async {
    await orderController.getOrdersbyUser();
    if(orderController.getOrders.isNotEmpty){
      List<int> productIds = orderController.getOrders.map((item) => item.productId).toList();
      orderController.fetchOrderProducts(productIds);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body:Obx(
          ()=> orderController.getProductByIdLoading.value  ? Center(child: CircularProgressIndicator())
              : SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: orderController.orderProductsList.length,
            itemBuilder: (context, index) {
              return OrderItems(voidCallback:(){
                Get.toNamed(RoutesName.productDetail,arguments: orderController.orderProductsList[index]);
              },product: orderController.orderProductsList[index]);
            },
          ),
        ),
      ),
    );
  }
}
