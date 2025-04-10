import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../route/routes.dart';
import '../widget/explore_latest_container.dart';

class ShowEaringCategory extends StatefulWidget {
  const ShowEaringCategory({super.key});

  @override
  State<ShowEaringCategory> createState() => _ShowEaringCategoryState();
}

class _ShowEaringCategoryState extends State<ShowEaringCategory> {
  UserProductController productController = Get.put(UserProductController());

  @override
  void initState() {
    productController.getEaringCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earing"),
      ),
      body: Obx((){
        if (productController.getEaringLoading.value) {
          return Center(child: CircularProgressIndicator()); // Loading state
        }
        if (productController.getEaringList.isEmpty) {
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
                itemCount: productController.getEaringList.length, // Number of items
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product =  productController.getEaringList[index];
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
