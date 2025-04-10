import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/auth_controller.dart';
import '../route/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "images/background.png",
                    width: screenWidth,
                    height: screenHeight * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("My Profile", style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Obx(
                        ()=> authController.user.value!.imageUrl == null ? CircleAvatar(radius: 50
                            ,backgroundImage: AssetImage("images/q_radhika.png")
                        ) :CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(authController.user.value!.imageUrl!),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        ()=> Text(
                          authController.user.value!.name ,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Overview",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                          Get.toNamed(RoutesName.myProfile);
                          },
                          child: buildAccountOption("My Profile", "images/l_person.png")
                        ),
                        GestureDetector(
                            onTap: (){
                              Get.toNamed(RoutesName.order_screen);
                            },
                            child: buildAccountOption("My Orders", "images/m_orders.png")),
                        GestureDetector(
                            onTap: (){
                              Get.snackbar("info: ", "No refund available");
                            },
                            child: buildAccountOption("Refund", "images/n_refund.png")),
                        GestureDetector(
                            onTap: (){
                              Get.snackbar("info: ", "No wishlist available");
                            },
                            child: buildAccountOption("Wishlist", "images/o_whislist.png")),
                        GestureDetector(
                            onTap: (){
                              authController.logout();
                            },
                            child: buildAccountOption("Log out", "images/p_logout.png")),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAccountOption(String title, String iconPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 18),
        ],
      ),
    );
  }
}
