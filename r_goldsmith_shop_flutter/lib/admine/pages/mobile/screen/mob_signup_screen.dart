import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';

import '../../../controller/admine_auth_controller.dart';

class MobSignupScreen extends StatefulWidget {
  const MobSignupScreen({super.key});

  @override
  State<MobSignupScreen> createState() => _MobSignupScreenState();
}

class _MobSignupScreenState extends State<MobSignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AdmineAuthController authController = Get.put(AdmineAuthController());

  Future<void> signup() async{
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    await authController.signup(name, email, password);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Stack(
          children: [
            Image.asset(
              "images/women.png",
              fit: BoxFit.cover,
            ),
            Positioned(
              top: screenHeight * 0.35, // Dynamic positioning
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      "Create account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent
                      ),
                    ),

                    Text(
                      "Enter your details to create an account!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                        width: screenWidth * 0.8,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(hintText: "Enter your Name",hintStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                        width: screenWidth * 0.8,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(hintText: "Enter your email",hintStyle: TextStyle(color: Colors.grey)),
                        )
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                        width: screenWidth * 0.8,
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(hintText: "Enter your password",hintStyle: TextStyle(color: Colors.grey),suffixIcon: Icon(Icons.remove_red_eye)),
                        )
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Obx(() =>
                        GestureDetector(
                          onTap: (){
                            signup();
                          },
                          child: Container(
                            height: screenHeight * 0.06,
                            width: screenWidth * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: authController.signupLoading.value ? CircularProgressIndicator(color: Colors.white,) : Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: screenWidth * 0.38,
                          color: Colors.grey,
                        ),
                        Text(" or ",style: TextStyle(color: Colors.grey,fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold),),
                        Container(
                          height: 1,
                          width: screenWidth * 0.38,
                          color: Colors.grey,
                        ),

                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed(AdmineRouteNames.mob_signup_screen);
                        },
                        child: Center(
                          child: Text(
                            "Log in ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
