import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import '../route/routes.dart';
import '../widget/explore_latest_container.dart';

class ShowBracletCategory extends StatefulWidget {
  const ShowBracletCategory({super.key});

  @override
  State<ShowBracletCategory> createState() => _ShowBracletCategoryState();
}

class _ShowBracletCategoryState extends State<ShowBracletCategory> {
  UserProductController productController = Get.put(UserProductController());

  @override
  void initState() {
    productController.getBracletCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Braclet"),
      ),
      body: Obx((){
        if (productController.getBracletLoading.value) {
          return Center(child: CircularProgressIndicator()); // Loading state
        }
        if (productController.getBracletList.isEmpty) {
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
                itemCount: productController.getBracletList.length, // Number of items
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product =  productController.getBracletList[index];
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
