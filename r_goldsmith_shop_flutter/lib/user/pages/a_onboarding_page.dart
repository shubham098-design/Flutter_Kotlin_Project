import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../route/routes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
              fit: BoxFit.cover, // Image responsive banane ke liye
            ),
            Positioned(
              top: screenHeight * 0.5, // Dynamic positioning
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
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      "Jewellery that Sparkle,\n Moments that shine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RoutesName.signup);
                      },
                      child: Container(
                        height: screenHeight * 0.06,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Sign up with Email",
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
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.snackbar("Cation", "Coming Soon");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/google.png", height: screenHeight * 0.03),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "Sign up with Google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesName.login);
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                      ],
                    ),
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
