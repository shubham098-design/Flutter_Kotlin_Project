import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';
import 'package:r_goldsmith_shop_flutter/admine/utils/custom_drawer.dart';

import '../../../controller/product_controller.dart';
import '../../../utils/Container_button.dart';
import '../../../utils/Custom_dashboard_top_container.dart';

class MobDashboardScreen extends StatefulWidget {
  const MobDashboardScreen({super.key});

  @override
  State<MobDashboardScreen> createState() => _MobDashboardScreenState();
}

class _MobDashboardScreenState extends State<MobDashboardScreen> {

  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height,
            color: Colors.white70,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap: () {
                        Get.toNamed(AdmineRouteNames.mob_add_category_screen);
                      },child: ContainerButton(text: "Add Category",color: Colors.lightBlueAccent,textColor: Colors.white,icon: Icons.add,)),
                      SizedBox(width: 20,),
                      GestureDetector(onTap: () {
                        Get.toNamed(AdmineRouteNames.mob_add_product_screen);
                      },child: ContainerButton(text: "Add Product",color: Colors.lightBlueAccent,textColor: Colors.white,icon: Icons.add,))
                    ],
                  ),
                ),
                Divider(color: Colors.grey,),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomDashboardTopContainer(icon: Icons.monetization_on_outlined,color: Colors.deepPurple,text: "Total Revenue",text2: "Rs.10000",),
                      CustomDashboardTopContainer(icon: Icons.shopping_cart_outlined,color: Colors.green,text: "Total Sales",text2: "3100",),
                      CustomDashboardTopContainer(icon: Icons.add_card_rounded,color: Colors.red,text: "Total Product",text2: "500",),
                      CustomDashboardTopContainer(icon: Icons.wallet_outlined,color: Colors.orange,text: "Balance",text2: "Rs.10000",),
                    ],
                  ),
                ),
                Row(
                  children: [

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
