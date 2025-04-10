import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/controller/product_controller.dart';
import 'package:r_goldsmith_shop_flutter/user/route/routes.dart';
import 'package:r_goldsmith_shop_flutter/user/services/shared_pref_services.dart';
import 'package:r_goldsmith_shop_flutter/user/widget/CartItems.dart';
import 'package:r_goldsmith_shop_flutter/user/widget/explore_latest_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller/auth_controller.dart';
import '../controller/cart_controller.dart';
import '../controller/order_controller.dart';
import '../controller/product_controller.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  CartController cartController = Get.put(CartController());
  UserProductController productController = Get.put(UserProductController());
  OrderController orderController = Get.put(OrderController());
  AuthController authController = Get.put(AuthController());
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  @override
  void initState() {
    super.initState();
    getCartAndFetchProducts();
  }

  void placeAllOrders() async {
    List<Map<String, dynamic>> orders = cartController.cartProductsList.map((product) {
      return {
        'total_price': product.price.toString(),
        'status': 'pending',
        'user_id': sharedPrefServices.getUserId(), // Apne user ID ko yahan set karo
        'product_id': product.id, // Product ID
        'quantity': "1", // Quantity
        'address': authController.user.value!.address, // Address
        'phone': authController.user.value!.phone, // Phone Number
        'payment_method': "Phone Pay", // Ya jo bhi payment method ho
      };
    }).toList();

    if (orders.isNotEmpty) {
      await orderController.sendMultipleOrders(orders);
    } else {
      Get.snackbar("Error", "Cart is empty!");
    }
  }


  /// Function jo `getCart` call karega aur fir `fetchCartProducts`
  void getCartAndFetchProducts() async {
    await cartController.getCart(); // 🔹 Pehle Cart ko fetch karo

    if (cartController.cartList.isNotEmpty) {
      // 🔹 Ab sabhi productIds ko extract karke fetchCartProducts me bhej do
      List<int> productIds = cartController.cartList.map((item) => item.productId).toList();
      cartController.fetchCartProducts(productIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.menu))
        ],
      ),
      body: Obx(
          () {
      return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleContainer(text: "1"),
                Expanded(child: Divider(color: Colors.grey, thickness: 2,)),
                CircleContainer(text: "2"),
                Expanded(child: Divider(color: Colors.grey, thickness: 2,)),
                CircleContainer(text: "3"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.watch_later_outlined, color: Colors.red,),
                SizedBox(width: 10,),
                Text("Delivery as soon as possible", style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: 20,),
            Obx(
                ()=> cartController.getCartLoading.value ?
                Center(child: CircularProgressIndicator(),) :
                SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartProductsList.length,
                  itemBuilder: (context, index) {
                    return CartItems(voidCallback2:(){
                      Get.toNamed(RoutesName.productDetail, arguments: cartController.cartProductsList[index]);
                    },product: cartController.cartProductsList[index]);
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Before your checkout ", style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesName.explore);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("See more", style: TextStyle(color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),),
                      Icon(Icons.arrow_forward, color: Colors.red,)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 0.9,
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ExploreLatestContainer(
                        voidCallback: (){
                          Get.offAndToNamed(RoutesName.productDetail, arguments:productController.products[index] );
                        },
                          product: productController.products[index]),
                    );
                  }
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Billing Detail", style: TextStyle(color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                    Divider(),
                    Obx(
                      ()=> BillingItems(text: "Item total",
                        text2:cartController.totalPrice.value.toString(),
                        icon: Icons.pages_outlined,),
                    ),
                    BillingItems(text: "Promo code",
                      text2: "Rs.0.00",
                      icon: Icons.arrow_circle_down_sharp,),
                    BillingItems(text: "Handling charge",
                      text2: "Rs.0.00",
                      icon: Icons.handshake_outlined,),
                    BillingItems(text: "Delivery charge",
                      text2: "Rs.0.00",
                      icon: Icons.delivery_dining_outlined,),
                    Divider(),
                    Obx(() {
                      return BillingItems(
                        text: "Total",
                        text2: cartController.totalPrice.value.toString(),
                        icon: Icons.currency_rupee,
                      );
                    }),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red, width: 1)
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.snackbar("info: ", "No coupon available");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("See all coupon",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            Icon(Icons.arrow_forward,color: Colors.white,)
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red, width: 1)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.delivery_dining_outlined, color: Colors.red,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Get free delivery",style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("Add product worth Rs. 0.00",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 1)
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.red,),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Delivery to Home", style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),),
                            Text("Random Address", style: TextStyle(color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesName.myProfile);
                          },
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red, width: 1)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("Change")),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Icon(Icons.monetization_on_rounded, color: Colors.red,),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Pay using", style: TextStyle(color: Colors.black54,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),),
                            Text("cash on Delivery", style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Spacer(),
                        Stack(
                          children: [
                            Container(
                              width: 185,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.red, width: 1)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                    ()=> Text("₹${cartController.totalPrice.value.toString()}", style: TextStyle(color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),),
                                    ),
                                    Text("Total", style: TextStyle(color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),),

                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 1,
                              child: GestureDetector(
                                onTap: (){
                                  if(authController.user.value!.address != null && authController.user.value!.address != "" &&authController.user.value!.phone != null && authController.user.value!.phone != ""){
                                    placeAllOrders();
                                    cartController.removeAllFromCart();
                                    cartController.cartProductsList.clear();
                                    cartController.totalPrice.value = 0;
                                  }else{
                                    Get.snackbar("Error", "Please Add  your address and phone number");
                                  }

                                },
                                child: Obx(
                                  ()=>orderController.getProductByIdLoading.value
                                      ? CircularProgressIndicator(color: Colors.white,) : Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.red, width: 1)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(child: Text("Checkout")),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
    );
    },
      ),
    );
  }


}

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Center(child: Text(text, style: TextStyle(color: Colors.white))),
    );
  }
}

class BillingItems extends StatelessWidget {
  const BillingItems({
    super.key,
    this.icon,
    required this.text,
    required this.text2,
  });

  final IconData? icon;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          text2,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
