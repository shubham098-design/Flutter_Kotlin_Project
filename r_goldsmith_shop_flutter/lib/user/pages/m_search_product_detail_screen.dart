import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/cart_controller.dart';
import 'e_product_detail_page.dart';

class SearchProductDetailScreen extends StatefulWidget {
  const SearchProductDetailScreen({super.key});

  @override
  State<SearchProductDetailScreen> createState() => _SearchProductDetailScreenState();
}

class _SearchProductDetailScreenState extends State<SearchProductDetailScreen> {
  final product = Get.arguments;
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
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
              child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.network(product['first_image_url'],fit: BoxFit.cover,)),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Text(product['name'],maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: Text(product['description'],maxLines: 3,
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
                  Text("Rs ${product['price']}",style: TextStyle(fontSize: 22,color: Colors.black),),
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
                  Container(
                    width: 120,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey,width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.remove_circle_outline,color: Colors.grey,),
                        Text("1",style: TextStyle(color: Colors.black),),
                        Icon(Icons.add_circle_outline,color: Colors.grey,)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      cartController.addToCart(3, product['id'],);
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
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
