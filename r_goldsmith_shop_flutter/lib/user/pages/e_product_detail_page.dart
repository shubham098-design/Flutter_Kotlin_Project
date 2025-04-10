import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/cart_controller.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/auth_controller.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/order_controller.dart';

import '../../admine/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final Product product = Get.arguments as Product;
  CartController cartController = Get.put(CartController());
  OrderController orderController = Get.put(OrderController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Handle share action
            },
          ),
        ],
      ),
      body:Obx(
        ()=> Column(
          children: [
            Container(
              width: 320,
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.red,width: 1)
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.network(product.firstImageUrl,fit: BoxFit.cover,)),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Text(product.name,maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Text(product.description,maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15,color: Colors.grey),),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.grey),),
                  Row(
                    children: [
                      CircleColorBox(colors: Colors.red, voidCallback: (){}),
                      SizedBox(width: 5,),
                      CircleColorBox(colors: Colors.yellow, voidCallback: (){}),
                      SizedBox(width: 5,),
                      CircleColorBox(colors: Colors.black, voidCallback: (){}),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Rs ${product.price}",style: TextStyle(fontSize: 22,color: Colors.red),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.star,color: Colors.red,),
                      Text(" 4.9 ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      Text(" (234 Reviews)",style: TextStyle(fontSize: 12,color: Colors.grey),),
                    ],
                  ),
                ],
              ),
            ),

            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                    onTap: (){
                      cartController.addToCart(product.id, "1");
                      cartController.getCart();
                    },
                    child: Container(
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: cartController.addToCartLoading.value ? CircularProgressIndicator(color: Colors.white,)
                          : Center(child: Text("Add to cart",style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(authController.user.value!.address != null && authController.user.value!.address != "" &&authController.user.value!.phone != null && authController.user.value!.phone != ""){
                        orderController.sendOrder(product.id, "1", product.price, authController.user.value!.address!, authController.user.value!.phone!, "phonepay");
                        cartController.removeFromCart(product.id);
                        cartController.getCart();
                      }else{
                        Get.snackbar("Error", "Please Add  your address and phone number");
                      }
                    },
                    child: orderController.sendOrderLoading.value ? CircularProgressIndicator(color: Colors.white,)
                        : Container(
                      width: 120,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text("Buy Now",style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class CircleColorBox extends StatelessWidget {
  final Color colors;
  final VoidCallback voidCallback;
  const CircleColorBox({super.key,required this.colors,required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: voidCallback,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            color: colors,
            shape: BoxShape.circle
        ),
      ),
    );
  }
}

