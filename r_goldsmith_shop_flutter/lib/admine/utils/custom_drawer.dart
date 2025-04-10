import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              color: Colors.blueGrey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("images/q_radhika.png", width: 40, height: 40),
                Text("Radhika", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Radhika@gmail.com"),
              ],
            ),
          ),
          buildDrawerItem(title: 'Dashboard', icon: Icons.dashboard_customize_outlined, voidCallback: ()=>navigate(0),
              titleColor: Get.currentRoute == AdmineRouteNames.mob_dashboard_screen ? Colors.blue : null,
              iconColor: Get.currentRoute == AdmineRouteNames.mob_dashboard_screen ? Colors.white : Colors.black,),
          buildDrawerItem(title: 'Products', icon: Icons.propane_outlined, voidCallback: ()=>navigate(1),
          titleColor: Get.currentRoute == AdmineRouteNames.mob_add_product_screen ? Colors.blue : null,
            iconColor: Get.currentRoute == AdmineRouteNames.mob_add_product_screen ? Colors.white : Colors.black,
          ),
          buildDrawerItem(title: 'Orders', icon: Icons.shopping_cart_outlined, voidCallback: ()=>navigate(2),
          titleColor: Get.currentRoute == AdmineRouteNames.mob_orders_screen ? Colors.blue : null,
            iconColor: Get.currentRoute == AdmineRouteNames.mob_orders_screen ? Colors.white : Colors.black,
          ),
          buildDrawerItem(title: 'Customers', icon: Icons.people_alt_outlined, voidCallback: ()=>navigate(3),
          titleColor: Get.currentRoute == AdmineRouteNames.mob_customer_screen ? Colors.blue : null,
            iconColor: Get.currentRoute == AdmineRouteNames.mob_customer_screen ? Colors.white : Colors.black,
          ),
          buildDrawerItem(title: 'Analytics', icon: Icons.analytics_outlined, voidCallback: ()=>navigate(4),
          titleColor: Get.currentRoute == AdmineRouteNames.mob_analytics_screen ? Colors.blue : null,
            iconColor: Get.currentRoute == AdmineRouteNames.mob_analytics_screen ? Colors.white : Colors.black,
          ),

        ],
      ),
    );
  }

  Widget buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback voidCallback,
    required Color? titleColor,
    required Color? iconColor,

  }) {
    return ListTile(
      leading: Icon(icon,color: iconColor,),
      title: Text(title,style: TextStyle(color: titleColor),),
      onTap: voidCallback,
    );
  }


  void navigate(int index){
    if(index == 0){
      Get.offAllNamed(AdmineRouteNames.mob_dashboard_screen);
    }else if(index == 1){
      Get.offAllNamed(AdmineRouteNames.mob_all_product_screen);
    }else if(index == 2){
      Get.offAllNamed(AdmineRouteNames.mob_orders_screen);
    }else if(index == 3){
      Get.offAllNamed(AdmineRouteNames.mob_customer_screen);
    }else if(index == 4){
      Get.offAllNamed(AdmineRouteNames.mob_analytics_screen);
    }
  }
}
