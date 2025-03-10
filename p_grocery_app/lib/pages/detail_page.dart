import 'package:flutter/material.dart';
import 'package:p_grocery_app/service/widget_support.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left : 20,top: 40),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffeeeeee),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30),),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(child: Image.asset("images/vegetables.png",height: 200,width: 300,fit: BoxFit.fill,)),
                  SizedBox(height: 30,),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xffc4c4c4),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.remove,color: Colors.white,),
                ),
                SizedBox(width: 10,),
                Text("2kg",style: AppWidget.headlinetextfieldStyle(),),
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff37a750),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.add,color: Colors.white,),
                )
              ],
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Vegetables",style: AppWidget.headlinetextfieldStyle(),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Color(0xfff9f9f9)),
                      child: Row(
                        children: [
                          Image.asset("images/star.png",fit: BoxFit.fill,height: 30,width: 30,),
                          SizedBox(width: 10,),
                          Text("4.5",style: AppWidget.mediumheadlinetextfieldStyle(),)
                        ],
                      ),
                    ),
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Color(0xfff9f9f9)),
                      child: Row(
                        children: [
                          Image.asset("images/fire.png",fit: BoxFit.fill,height: 30,width: 30,),
                          SizedBox(width: 10,),
                          Text("100 kcl",style: AppWidget.mediumheadlinetextfieldStyle(),)
                        ],
                      ),
                    ),
                  ),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Color(0xfff9f9f9)),
                      child: Row(
                        children: [
                          Image.asset("images/clock.png",fit: BoxFit.fill,height: 30,width: 30,),
                          SizedBox(width: 10,),
                          Text("8-10 min",style: AppWidget.mediumheadlinetextfieldStyle(),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Related Items",style: AppWidget.SimpleheadlinetextfieldStyle(),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset("images/brinjal.png",fit: BoxFit.contain,height: 60,width: 60,),

                  ),
                  SizedBox(width: 20,),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset("images/green.png",fit: BoxFit.contain,height: 60,width: 60,),

                  ),
                  SizedBox(width: 20,),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset("images/onion.png",fit: BoxFit.contain,height: 60,width: 60,),

                  ),
                  SizedBox(width: 20,),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset("images/cabbage.png",fit: BoxFit.contain,height: 60,width: 60,),

                  ),


                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 40,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Total Price",style: AppWidget.mediumheadlinetextfieldStyle(),),
                      Text("\$20.00",style: AppWidget.simpleheadlinetextfieldStyle(),),
                    ],
                  ),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left:10),
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(color: Color(0xff33a853),borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60)
                                ),
                                child: Icon(Icons.shopping_cart_outlined,color: Colors.black,)
                            ),
                            SizedBox(width: 10,),
                            Text("Add to Cart",style: AppWidget.whiteheadlinetextfieldStyle(),)
                          ],
                        ),
                      )
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
