import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../route/routes.dart';
import '../widget/explore_latest_container.dart';

class ShowBanglesCategory extends StatefulWidget {
  const ShowBanglesCategory({super.key});

  @override
  State<ShowBanglesCategory> createState() => _ShowBanglesCategoryState();
}

class _ShowBanglesCategoryState extends State<ShowBanglesCategory> {
  UserProductController productController = Get.put(UserProductController());

  @override
  void initState() {
    productController.getNecklaceCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bangles"),
      ),
      body: Obx((){
        if (productController.getNecklaceLoading.value) {
          return Center(child: CircularProgressIndicator()); // Loading state
        }
        if (productController.getNecklaceList.isEmpty) {
          return Center(child: Text("No products found"));
        }
        return  Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6, // Adjust ratio to prevent overflow
                ),
                itemCount: productController.getNecklaceList.length, // Number of items
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product =  productController.getNecklaceList[index];
                  return ExploreLatestContainer(product: product,voidCallback: (){
                    Get.toNamed(RoutesName.productDetail,arguments: product);
                  },);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
