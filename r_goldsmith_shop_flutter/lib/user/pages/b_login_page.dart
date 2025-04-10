import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/auth_controller.dart';
import 'package:r_goldsmith_shop_flutter/user/route/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.put(AuthController());

  Future<void> login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    await authController.login(email, password);
  }

  @override
  void dispose(){
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
              top: screenHeight * 0.45, // Dynamic positioning
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
                      "Welcome back!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent
                      ),
                    ),

                    Text(
                      "Enter your email and password to log in!",
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
                    GestureDetector(
                      onTap: (){
                        login();
                      },
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: authController.loginLoading.value ? CircularProgressIndicator(color: Colors.white,)
                            : Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
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
                          Get.toNamed(RoutesName.signup);
                        },
                        child: Center(
                          child: Text(
                            "Sign up ",
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
