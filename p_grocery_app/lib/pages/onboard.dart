import 'package:flutter/material.dart';
import 'package:p_grocery_app/service/widget_support.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff6f1),
      body: Container(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffeff6f1)),
                child: Image.asset('images/onboard.png',height: MediaQuery.of(context).size.height/2,)
            ),
            Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xffeff6f1),borderRadius: BorderRadius.only(topLeft: Radius.circular(80),topRight: Radius.circular(80))),
              child: Column(
                children: [
                  SizedBox(height: 60,),
                  Text("Shop Your Daily",style: AppWidget.headlinetextfieldStyle(),),
                  Text("Necessary",style: AppWidget.orangeheadlinetextfieldStyle(),),
                  SizedBox(height: 20,),
                  Text("Groceries made easy - \nShop, Click, Delivered!",style: AppWidget.simpleheadlinetextfieldStyle(),textAlign: TextAlign.center,),
                  SizedBox(height: 30,),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.6,
                      decoration: BoxDecoration(color: Color(0xff33a853),borderRadius: BorderRadius.circular(20)),
                      child: Center(child: Text("Get Started",style: AppWidget.whiteheadlinetextfieldStyle(),)),
                    ),
                  )
                ]
              ),
            ),
            ]
        ),
      ),
    );
  }
}
