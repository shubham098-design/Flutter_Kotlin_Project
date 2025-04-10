import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/product_controller.dart';
import '../../../utils/custom_drawer.dart';
import '../../../utils/custom_text_field.dart';

class MobAddProductScreen extends StatefulWidget {
  const MobAddProductScreen({super.key});

  @override
  State<MobAddProductScreen> createState() => _MobAddProductScreenState();
}

class _MobAddProductScreenState extends State<MobAddProductScreen> {
  ProductController addProductController = Get.put(ProductController());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  void addProduct(){
    addProductController.addProduct(nameController.text.trim(),
        descriptionController.text.trim(), categoryController.text.trim(),
        priceController.text.trim(), stockController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Desktop Add Product Screen")),
      body: Obx(()=> Container(
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
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Product Category & stock"),
                      SizedBox(height: 10),
                      CustomTextField(controller: categoryController,hintText: "Enter Product Category"),
                      SizedBox(height: 10),
                      CustomTextField(hintText: "Enter Product stock",controller: stockController),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child:Column(
                  children: [
                    Text("Media"),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black54, width: 1),
                        ),
                        child: addProductController.image1.value != null ? Image.file(addProductController.image1.value!) : IconButton(onPressed: (){
                          addProductController.pickImage1();
                        }, icon: Icon(Icons.add,size: 20,)),

                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
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
                      Text("External Detail"),
                      SizedBox(height: 20,),
                      CustomTextField(controller: priceController,hintText: "Enter Product Price"),
                      SizedBox(height: 10),
                      CustomTextField(hintText: "Enter Product stock"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){addProduct();},
              child: addProductController.addProductLoading.value ?
              CircularProgressIndicator(color: Colors.red,) : Text("Add Product"),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
