import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/product_controller.dart';
import '../../../utils/custom_text_field.dart';

class MobAddCategoryScreen extends StatefulWidget {
  const MobAddCategoryScreen({super.key});

  @override
  State<MobAddCategoryScreen> createState() => _MobAddCategoryScreenState();
}

class _MobAddCategoryScreenState extends State<MobAddCategoryScreen> {

  ProductController addProductController = Get.put(ProductController());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addCategory(){
    addProductController.addCategory(nameController.text.toLowerCase().trim(), descriptionController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: Obx(
          ()=> Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("General Information"),
                      SizedBox(height: 10),
                      CustomTextField(controller: nameController,hintText: "Enter Product Name"),
                      SizedBox(height: 10),
                      CustomTextField(controller: descriptionController,hintText: "Enter Product Description"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){addCategory();},
                child: addProductController.addCategoryLoading.value ?
                CircularProgressIndicator(color: Colors.red,) : Text("Add Category"),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
