import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:r_goldsmith_shop_flutter/user/controller/product_controller.dart';

import '../route/routes.dart';
import '../widget/category_items.dart';
import '../widget/explore_latest_container.dart';
import '../widget/jewelry_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  UserProductController productController = Get.put(UserProductController());
  bool isTextFieldActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              SizedBox(height: 10,),
              Container(
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey,width: 2),
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => productController.search(value),
                      onTap: (){
                        setState(() {
                          isTextFieldActive = true;
                        });
                      },
                    ),
                  )
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: Colors.grey)),
            ],
          )
        ],
      ),
      body: Obx(
          (){
            if (productController.getProductsLoading.value || productController.isLoading.value) {
              return Center(child: CircularProgressIndicator()); // Loading state
            }

            if (productController.products.isEmpty) {
              return Center(child: Text("No products found"));
            }
          return Column(
          children: [
            SizedBox(height: 10,),
            if(!isTextFieldActive) Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6, // Adjust ratio to prevent overflow
                    ),
                    itemCount: productController.products.length, // Number of items
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product =  productController.products[index];
                      return ExploreLatestContainer(product: product,voidCallback: (){
                        Get.toNamed(RoutesName.productDetail,arguments: product);
                      },);
                    },
                  ),
                ),
              ),
            ),
            if(isTextFieldActive) Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    itemCount: productController.searchProduct.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 8, // Horizontal space
                      mainAxisSpacing: 8, // Vertical space
                      childAspectRatio: 0.7, // Adjust for height-width ratio
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      var product = productController.searchProduct[index];
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(RoutesName.search_product_detail_screen,arguments: product);
                        },
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    child: Image.network(
                                      product['first_image_url'],
                                      width: double.infinity,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.favorite_border,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Rs.${product['price']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ),
            ),
          ],
        );
        },
      ),
    );
  }

}




